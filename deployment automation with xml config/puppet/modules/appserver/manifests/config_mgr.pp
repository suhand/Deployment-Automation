class appserver::config_mgr{

        $ipAdd 		   = $::ipaddress
        $allConfigurations = getAllConfigurations($ipAdd)
        $serverOptions     = getServerOptions($allConfigurations['configurations'])
	$http_proxyport    = '80'
	$https_proxyport   = '443'

        package { 'unzip':
                  ensure => present,
        }

	exec {  "Stop_process_and_remove_CARBON_HOME":
                path        => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
                command => "kill -9 `cat /opt/wso2as-5.2.1/wso2carbon.pid` ; rm -rf /opt/wso2as-5.2.1";
        }
        ->
        exec {  "remove_java_dirs":
                path        => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
                command => "rm -rf /opt/jdk1.6.0_24 ; rm -rf /opt/java";
        }
        ->
        file { '/opt/wso2as-5.2.1.zip':
                replace => "no",
                ensure => present,
                source => "puppet:///modules/appserver/wso2as-5.2.1.zip",
        }

        file { '/opt/jdk1.6.0_24.tar.gz':
                replace => "no",
                ensure => present,
                source => "puppet:///modules/packs/jdk1.6.0_24.tar.gz",
        }

        exec {  "installing_java":
                user => 'root',
                path        => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
                command => "tar -xvzf /opt/jdk1.6.0_24.tar.gz  -C /opt/; ln -s /opt/jdk1.6.0_24 /opt/java",
                creates => "/tmp/installjava.log",
                require   => File["/opt/jdk1.6.0_24.tar.gz"];

                "extracting appserver":
                user => 'root',
                path        => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/java/bin/',
                command => "unzip /opt/wso2as-5.2.1.zip -d /opt/",
                require   => Exec["installing_java"];
        }

        exec {  'wait_till_product_pack_extracts' :
                require => Exec["extracting appserver"],
                command => "sleep 30",
                path => "/usr/bin:/bin",
        }
        ->
        file {  "/opt/wso2as-5.2.1/repository/conf/axis2/axis2.xml":
                ensure  => file,
                content => template('appserver/axis2_mgr.xml.erb'),
        }
        ->
        file {  "/opt/wso2as-5.2.1/repository/conf/carbon.xml":
                ensure  => file,
                content => template('appserver/carbon_mgr.xml.erb'),
        }
        ->
        file {  "/opt/wso2as-5.2.1/repository/conf/tomcat/catalina-server.xml":
                ensure  => file,
                content => template('appserver/catalina-server.xml.erb'),
        }
        ->
        exec {  "strating_appserver":
                user    => 'root',
                environment => "JAVA_HOME=/opt/java",
                path        => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/java/bin/',
                unless  => "test -f /opt/wso2as-5.2.1/wso2carbon.lck",
                command => "touch /opt/wso2as-5.2.1/wso2carbon.lck; /opt/wso2as-5.2.1/bin/wso2server.sh  ${serverOptions} > /dev/null 2>&1 &",
                creates => "/opt/wso2as-5.2.1/repository/wso2carbon.log",
                require   => Exec["wait_till_product_pack_extracts"];
        }
}


class appserver inherits appserver::params {
	
        $serverName = $::hostname
	$setServerOption = $servers[$serverName][serverOptions]

	define fill_templates($axis2, $carbon, $clustering, $serverOptions) {
        	$ipAdd = $::ipaddress
        	$hostName = $::hostname
		notify{"hostName -> $hostName, arrayName -> ${name}, serverOptions -> $serverOptions":}
        	if $hostName == "${name}" {
                	notify {"host name match found for $hostName for $ipAdd":}
                	file {  "/opt/wso2as-5.2.1/repository/conf/axis2/axis2.xml":
                        	ensure  => file,
                        	content => template('appserver/axis2.xml.erb'),
                	}
                	->
                	file {  "/opt/wso2as-5.2.1/repository/conf/carbon.xml":
                        	ensure  => file,
                        	content => template('appserver/carbon.xml.erb'),
                	}
                	->
                	file {  "/opt/wso2as-5.2.1/repository/conf/tomcat/catalina-server.xml":
                        	ensure  => file,
                        	content => template('appserver/catalina-server.xml.erb'),
                	}
       	 	}
	}

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
                command => "sleep 10",
                path => "/usr/bin:/bin",
        }

	create_resources(appserver::fill_templates, $servers, $serversDefaults)

	Exec<| title == "wait_till_product_pack_extracts" |> -> Appserver::Fill_Templates<| |> -> Exec<| title == "starting_appserver" |>

	exec {  "starting_appserver":
                user    => 'root',
                environment => "JAVA_HOME=/opt/java",
                path        => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/java/bin/',
                unless  => "test -f /opt/wso2as-5.2.1/wso2carbon.lck",
                command => "touch /opt/wso2as-5.2.1/wso2carbon.lck; /opt/wso2as-5.2.1/bin/wso2server.sh  $setServerOption > /dev/null 2>&1 &",
                creates => "/opt/wso2as-5.2.1/repository/wso2carbon.log",
                require   => Exec["wait_till_product_pack_extracts"];
        }
}

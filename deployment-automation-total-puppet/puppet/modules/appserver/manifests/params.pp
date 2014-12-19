class appserver::params {
	
	$owner  = 'root'
  	$group  = 'root'
  	$target = '/opt'

	$deployment_code = 'as'
	$service_code   = 'as'
	$version = '5.2.1'
	$offset = 0
  	$carbon_version = "wso2${service_code}-${version}"
  	$carbon_home    = "${target}/${carbon_version}"
	
	$hazelcast_port = 4100
        $elb_common_port = 4500
        $elb_mgt_cluster_port = 4500
        $elb_wkr_cluster_port = 4600

	# Available JDK versions
	# jdk1.6.0_24
	# jdk1.7.0_51
	$jdk_version = 'jdk1.6.0_24'
	$jdk_home = "${target}/${jdk_version}"	

	$jdk_file	= "${jdk_home}.tar.gz"
	$pack_file	= "${carbon_home}.zip"

	$servers = {
                appserver-mgr2 => { axis2   => {subDomain => 'mgt',},
                                    carbon  => {subDomain => 'mgt',},
				    serverOptions => '-Dsetup', 
				    server_home => $carbon_home, },
                appserver-wkr2 => { axis2   => {subDomain => 'worker', members => ['10.0.2.86']},
                                    carbon => {subDomain => 'worker',},
				    serverOptions => '-DworkerNode=true',
				    server_home => $carbon_home, },
        }

        $serversDefaults = {
                clustering => 'true',
        }	
}

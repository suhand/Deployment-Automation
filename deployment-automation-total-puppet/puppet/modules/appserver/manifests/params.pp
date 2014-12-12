class appserver::params {
	$servers = {
                appserver-mgr2 => { axis2   => {subDomain => 'mgt',},
                                    carbon  => {subDomain => 'mgt',},
				    serverOptions => '-Dsetup',  },
                appserver-wkr2 => { axis2   => {subDomain => 'worker', members => ['10.0.2.42']},
                                    carbon => {subDomain => 'worker',},
				    serverOptions => '-DworkerNode=true',  },
        }

        $serversDefaults = {
                clustering => 'true',
        }	
}

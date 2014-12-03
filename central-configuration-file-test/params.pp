class appserver::params ($say_hello_to = 'guys and gals') {
        $myname = 'welcome file.xml'
        $serverOptions     = '-DworkerNode=true'
        $subDomain         = 'worker'
		$servers           = { '192.168.1.156' => '4100', '192.168.1.157' => '4000' }
}

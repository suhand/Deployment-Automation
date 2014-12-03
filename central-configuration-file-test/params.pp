class appserver::params ($say_hello_to = 'guys and gals') {
	#$say_hello_to = 'guys and gals'
        $myname = 'welcome file.xml'
        $serverOptions     = '-DworkerNode=true'
        $subDomain         = 'worker'
        $members           = ['10.0.1.196', '10.0.1.198', '10.0.1.200', '10.0.1.202']
	$servers           = { '192.168.1.156' => '4100', '192.168.1.157' => '4000' }
}

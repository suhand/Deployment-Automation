import 'appserver'

node 'default' {
	include appserver
}

node 'appserver-wkr' {
	# params.pp -> init.pp (class appserver)
	include appserver
}

node 'test-node' {

	#this is a test
	$say_hello_to = 'guys and gals'
        $myname = 'welcome file.xml'
	$serverOptions     = '-DworkerNode=true'
        $subDomain         = 'worker'
        $members           = ['10.0.1.196', '10.0.1.198', '10.0.1.200', '10.0.1.202']

        file {  "/tmp/$myname":
                ensure  => file,
                content => template('appserver/polite-file.erb'),
        }

}

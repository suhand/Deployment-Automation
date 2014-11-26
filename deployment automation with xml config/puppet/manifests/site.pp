import 'appserver'

node 'appserver-mgr' {
	include appserver::config_mgr
}

node 'appserver-wkr' {
	include appserver::config_wkr
}

node 'dummy' {
	include change_config
}

node 'test-node' {
	#this is a test

 	#$ipAdd = $::ipaddress
 	#$hostName = $::hostname
	#$allConfigurations=getAllConfigurations($ipAdd)

 	#host { 	'my.puppet.site.com':
    #	ensure => 'present',       
    #	target => '/etc/hosts',    
    #	ip => '192.90.85.69',         
 	#}

	$say_hello_to = 'guys and gals'
    $myname = 'welcome file.xml'

    file {  "/tmp/$myname":
            ensure  => file,
            content => template('appserver/polite-file.erb'),
    }

}

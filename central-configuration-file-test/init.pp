class appserver inherits appserver::params{
	file {  "/tmp/$myname":
                ensure  => file,
                content => template('appserver/polite-file.erb'),
        }
}


$appserver = { 
    'manager' => { 
        'servers' => [ 'appserver-mgr1', 'appserver-mgr2', ], 
        'axis2' => { 'subDomain' => 'mgt', 'clustering' => 'true' }, 
        'carbon' => { 'subDomain' => 'mgt' }, 
    },
    'worker' => { 
        'servers' => [ 'appserver-wkr1', 'appserver-wkr2', 'appserver-wkr3', ], 
        'axis2' => { 'subDomain' => 'worker', 'clustering' => 'true' }, 
        'carbon' => { 'subDomain' => 'worker' }, 
    }
}

$esb = { 
	...
}

$elb = {
	...
}
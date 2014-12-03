class appserver inherits appserver::params{
	file {  "/tmp/$myname":
                ensure  => file,
                content => template('appserver/polite-file.erb'),
        }
}



import 'appserver'

node 'default' {

}

node 'appserver-wkr' {
	# params.pp -> init.pp (class appserver)
	include appserver
}


#import os
#import time
#from novaclient.v1_1 import client
import ConfigParser

# Global variables
config = ConfigParser.RawConfigParser(allow_no_value=True)

# Get environment
def get_environment():
	config.read('deployment.cfg')
	return config.get('environment', 'env')

# Load environment configuration
def get_openstack_image():
	config.read('deployment.cfg')
	return config.get('envconfig', 'image')

def get_openstack_flavor():
	config.read('deployment.cfg')
	return config.get('envconfig', 'flavor')

def get_openstack_network():
	config.read('deployment.cfg')
	return config.get('envconfig', 'network')

def get_openstack_instancePassword():
	config.read('deployment.cfg')
	return config.get('envconfig', 'instancePassword')

def get_openstack_keyPair():
	config.read('deployment.cfg')
	return config.get('envconfig', 'keyPair')

# Nova credentials are loaded from OS environmental variables
def load_server_config():
	
	serverList = []
	
	config.read('deployment.cfg')
	
	dic = dict(config.items('nodes'))
	
	for node, ip in dic.iteritems():
    		serverList.append(node)

	print serverList
	serverList.sort()
	print serverList
	return serverList

# This block will only get executed when running directly
# This can be used to debug given nova client credentials and authentication
if __name__ == '__main__':
    try:
	serverList = load_server_config()

    except BaseException as b:
        print 'Exception in load_deployment_config: ', b



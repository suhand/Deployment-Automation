import os
from novaclient.v1_1 import client
#import ec2
from openstack import initialize_cluster
from load_deployment_config import load_server_config

if __name__ == '__main__':
    try:
	# load deployment configurations
	print (" Loading deployment cluster configuration...")
	serverList = load_server_config()
	
	# load nova configs and create instances
	print (" Loading nova configuration and spawning instances...")
	imageName = "suhan-daf-agentv4-ubuntu14.04"
	flavorName = "m2.small"
	networkName = "qaa-net"
	instancePassword = "suhan"
	keyPairName = "mycloudkey"
	
	cluster = initialize_cluster(serverList, imageName, flavorName, networkName, instancePassword, keyPairName)

    except BaseException as b:
        print 'Exception in __main__.py: ', b

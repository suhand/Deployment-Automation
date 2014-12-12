import os
from novaclient.v1_1 import client
from load_deployment_config import load_server_config
from openstack import terminate_instances

if __name__ == '__main__':
    try:
	print (" Loading deployment node configurations...")
        serverList = load_server_config()
	terminate_instances(serverList)

    except BaseException as b:
	print 'Exception in terminateInstances.py: ', b

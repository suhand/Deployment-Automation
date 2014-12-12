#import os
#import time
#from novaclient.v1_1 import client

# Nova credentials are loaded from OS environmental variables
def load_server_config():

	with open('nodes.txt', 'r') as f:
    		cluster = f.readlines()

    		for line in cluster:
			serverList = line.split()
        		print serverList
			#serverList.append(words)
	return serverList
# This block will only get executed when running directly
# This can be used to debug given nova client credentials and authentication
if __name__ == '__main__':
    try:
	serverList = load_server_config()

    except BaseException as b:
        print 'Exception in load_deployment_config: ', b



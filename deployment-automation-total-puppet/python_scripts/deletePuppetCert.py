from subprocess import call
from load_deployment_config import load_server_config

if __name__ == '__main__':
    try:
        print (" Loading server node structure...")
        serverList = load_server_config()
	for vm in serverList:
                print (" Deleting certificate for " + vm + ".openstacklocal...")
		call("puppet cert clean " + vm + ".openstacklocal", shell=True)

    except BaseException as b:
        print 'Exception in deletePuppetCert.py: ', b

#!/usr/bin/env python
# ----------------------------------------------------------------------------
#  Copyright 2005-2014 WSO2, Inc. http://www.wso2.org
#
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.
# ----------------------------------------------------------------------------
from novaclient.v1_1 import client
import os
from subprocess import call

# Retrieve authentication credentials from OS environmental variables
# These are defined at /root/.bash_profile
# Current test bed used is Cloud Support Labs/Tenant name: Stratos
def get_nova_creds():
	return { 'username': os.environ['OS_USERNAME'],
                 'api_key': os.environ['OS_PASSWORD'],
                 'auth_url': os.environ['OS_AUTH_URL'],
                 'project_id': os.environ['OS_TENANT_NAME']
               }

# Main body of the script
if __name__ == '__main__':
    try:
        creds = get_nova_creds()
        nova = client.Client(**creds)
	print("Generating nova credentials...")
	#nova.authenticate()

        # This is where server image, flavor and network information is retrieved
	print("Retrieving image, flavor and network information...")

	# Find image= "ubuntu-12.04-automated" 
        image=nova.images.find(name="suhan-daf-agent-ubuntu12.04")
	#image=nova.images.find(name="Ubuntu Cloud 12.04")
	print image
        
	# Find flavor for 2GB RAM
	#flavor=nova.flavors.find(name="m1.medium")
	flavor=nova.flavors.find(name="m1.tiny")
	print flavor
	
	# Since multiple networks find network-routable network
	# This enables ssh capabilities to the instance created
        network=nova.networks.find(label="net0")
	# Retrieve the newtork id string from the network object we created
        nics = [{'net-id': network.id}]
	print network
	#print nics

        server = nova.servers.create(name = "daf-agent-ganglia-ubuntu12.04",password="suhan",image= image.id,flavor= flavor.id ,key_name = "mycloudkey",nics =[{'net-id': network.id ,'v4-fixed-ip': ''}])
	print "---- OpenStack instance successfully created ----"
	
    except BaseException as b:
        print 'exception is ', b


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
import time
import libxml2
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

	i=0
	instanceList=[]

	#this dictionary contains the IP addresses of the populated instances
	ipmap = {}
        
	# Get the configurations details of the deployment
	doc = libxml2.parseFile('conf.xml')

        # Load credentials
        creds = get_nova_creds()
        nova = client.Client(**creds)
	print("Generating nova credentials...")
	#nova.authenticate()

        # This is where server image, flavor and network information is retrieved
	print("Retrieving image, flavor and network information...")

	# Find image= "ubuntu-12.04-automated" 
        image=nova.images.find(name="suhan-daf-agent2-ubuntu14.04")
	#image=nova.images.find(name="Ubuntu Cloud 12.04")
	print image
        
	# Find flavor for 2GB RAM
	flavor=nova.flavors.find(name="m3.tiny")
	print flavor
	
	# Since multiple networks find network-routable network
	# This enables ssh capabilities to the instance created
        network=nova.networks.find(label="net0")
	# Retrieve the newtork id string from the network object we created
        nics = [{'net-id': network.id}]
	print network
	#print nics

	for node in doc.xpathEval("//node"):
                server = nova.servers.create(name = node.prop('id'),password="suhan",image= image.id,flavor= flavor.id ,key_name = "mycloudkey",nics =[{'net-id': network.id ,'v4-fixed-ip': ''}])
                instanceList.append(server)
		print server.id
                time.sleep(40)
                print instanceList[i].status
                #floating_ip = nova.floating_ips.create(nova.floating_ip_pools.list()[0].name)
                #print floating_ip
		#server.add_floating_ip(floating_ip)
		print instanceList[i].addresses
                ipmap[node.prop('id')] =  (((instanceList[i].addresses)['net0'])[0])['addr']
                print ipmap[node.prop('id')]
		print ipmap
		instanceID=instanceList[i].id
                instanceList[i].suspend()
		#print instanceList[i].status
                i=i+1
	time.sleep(5)
        j=0;
	print "---- end of instance spawning ----"
	
	while(j<len(doc.xpathEval("//node"))):
		print len(doc.xpathEval("//node"))
        	currentNode= doc.xpathEval("//node")[j]
        	configFilepath = '/tmp/'+ ipmap[currentNode.prop('id')]
		xmlstring = currentNode.serialize('UTF-8', 1).replace('\n', '')
		print xmlstring
        	t = xmlstring.format(**ipmap)
        	f = open(configFilepath,'w+')
        	f.write('configurations,'+ t)
        	f.close()
        	instanceList[j].resume()
		time.sleep(5)
		instanceList[j].reboot()
		#call("while ! echo exit | nc "+ipmap[currentNode.prop('id')]+" 9443; do sleep 10; done", shell="True")	
		#print "Server "+ipmap[currentNode.prop('id')]+" is running now"
		j=j+1
	
    except BaseException as b:
        print 'exception is ', b


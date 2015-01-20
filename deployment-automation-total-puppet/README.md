### DEPLOYMENT AUTOMATION

#### RUNNING SCRIPTS

##### STARTING INSTANCES

1. RUN `__main__.py` SCRIPT  
`	>python __main__.py`
	
##### TERMINATION OF INSTANCES

1. RUN `terminateInstances.py` SCRIPT  
`	>python terminateInstances.py`
	
      + THIS SCRIPT WILL TERMINATE THE INSTANCES MENTIONED IN `deployment.cfg`
	UNDER `[nodes]` SECTION. THIS ATTEMPT WILL BE SUCCESSFUL GIVEN THAT 
	YOU HAVE ALREADY CREATED THE NODES IN OPENSTACK AND THEY ARE UP AND
	RUNNING IN OPENSTACK ENVIRONMENT.
      + `class novaclient.v1_1.servers.Server.delete()` IS USED WHICH WILL 
	FIRST SHUTDOWN THE INSTANCE AND THEN DELETE IT FROM OPENSTACK ENV.
      + OPENSTACK CLOUD RESOURCES WE HAVE IS VERY LIMITED. THEREFORE TO GAIN
	RESOURCES TO SPAWN NEW CLUSTERS THIS SCRIPT IS TO BE RUN.

2. RUN `deletePuppetCert.py` SCRIPT (OPTIONAL)  
`	>python deletePuppetCert.py`

      + [OPTIONAL] RUN THIS SCRIPT ONLY IF YOU ARE PLANNING TO USE THE SAME 
	NODE NAMES MENTIONED UNDER `deployment.cfg` FILE `[nodes]` SECTION.
      + THIS SCRIPT WILL DELETE THE PUPPET AGENTS' CERTIFICATES LISTED UNDER
	PUPPET MASTER FOR THE CORRESPONDING AGENTS' IP ADDRESSES.
      + IF WE DON'T DELETE THE CERTIFICATES FOR THE PREVIOUSLY SPAWNED PUPPET
	AGENTS, WHEN WE USE THE SAME NAMES FOR THE NEW CLUSTER, OUR PUPPET 
	CATELOG RUNS WILL BE FAILED ON AGENTS DUE TO CERTIFICATE MISMATCH.
	
3. RUN `floatingIpDelete.sh` SCRIPT  
`	>sh floatingIpDelete.sh`

      + [IMPORTANT] ADD THE FLOATING IP ADDRESSES YOU WANT TO DELETE FROM
	OPENSTACK ENVIRONMENT BEFORE RUNNING THE SCRIPT.
      + THIS IS IMPORTANT SINCE WHEN WE DELETE/TERMINATE AN INSTANCE, ONLY 
	ITS CORRESPONDING FLOATING IP IS DISASSOCIATED, BUT NOT DELETED FROM
	OPENSTACK ENVIRONMENT. 
      + IF WE DON'T DELETE THE FLOATING IPS WHICH ARE NOT ASSOCIATED WITH ANY
	RUNNING INSTANCES, THE FLOATING IP POOL WILL EXCEED ITS LIMIT AND 
	CAN CAUSE INSTABILITY OF THE OPENSTACK ENVIRONMENT.

#### BRIEF INTRODUCTION

`__main__.py` is the script to be invoked when starting deployment automation.

The `deployment.cfg` file contains all the configuration information required for the 
deployment automation process.
It consists of following sections.

1. environment name
2. environment configuration data
3. cluster configuration automated/manual
4. cluster node list/size

`load_deployment_config.py` will load these configuration data from `deployment.cfg` file
and feed to `__main__.py` script.

When cluster configuration is set to manual, `config.pp` file is to be filled by the user
according to the cluster configuration.
As for an example each node's `axis2.xml`, `catalina-server.xml`, `carbon.xml` configuration 
data to be included in this hierarchical data structure.

`openstack.py` script contains the instance spawning and maintenance activities which is
specific to OpenStack environment.

Clean up process will be carried out by `terminateInstances.py` and `deletePuppetCert.py`
* `terminateInstances.py` will terminate the instances in OpenStack environment.
* `deletePuppetCert.py` execution is needed after every successful test run if you are
planning to use the same hostnames for the next test iteration.

#### TRYING WITH DIFFERENT JAVA VERSIONS

Please note that the whole cluster will be spawned using the given java version.

1. Rename `*.tar.gz` downloaded jdk file.  
When extracting the `*.tar.gz` file you have downloaded from web there is a specific 
folder naming convension java follows.  
e.g.: extracting `jdk-7u51-linux-x64.tar.gz` file generates a folder named `jdk1.7.0_51`.
Therefore rename your file downloaded from `jdk-7u51-linux-x64.tar.gz` to `jdk1.7.0_51.tar.gz`.

2. After renaming the file, copy to `/etc/puppet/modules/packs/files` location.  
e.g.: `jdk1.7.0_51.tar.gz`

3. Add your new java version to `config.pp` configuration file  
e.g.: `$jdk_version = 'jdk1.7.0_51'`

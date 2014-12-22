### Deployment Automation - puppet

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

#### Trying with different java versions

Please note that the whole cluster will be spawned using the given java version.

1. Rename `*.tar.gz` downloaded jdk file.
When extracting the `*.tar.gz` file you have downloaded from web there is a specific 
folder naming convension java follows.
e.g.: extracting `jdk-7u51-linux-x64.tar.gz` file generates a folder named `jdk1.7.0_51`.
Therefore rename your file downloaded from `jdk-7u51-linux-x64.tar.gz` to `jdk1.7.0_51.tar.gz`.

2. After renaming the file, copy to `/etc/puppet/modules/packs/files` location.
e.g.: `jdk1.7.0_51.tar.gz`

3. Add your new java version to `config.pp` configuration file
e.g.: `$jdk_version = 'jdk1.6.0_24'`

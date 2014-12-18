### Deployment Automation - puppet

`__main__.py` is the script to be invoked when starting deployment automation.

The `deployment.cfg` file contain all the configuration information required for the 
deployment automation process
It contain following sections.

1. environment name
2. environment configuration data
3. cluster configuration automated/manual
4. cluster node list/size

`load_deployment_config.py` will load these configuration data from `deployment.cfg` file
and feed to `__main__.py` script.

When cluster configuration is manual, `config.pp` file is to be edited by the user
according to the cluster configuration.
As for an example each node's `axis2.xml`, `catalina-server.xml`, `carbon.xml` configuration 
data to be included in this hierarchical data structure.

`openstack.py` script contains the instance spawning and maintenance activities only
specific to OpenStack environment.

Clean up process will be taken cared by `terminateInstances.py` and `deletePuppetCert.py`
* `terminateInstances.py` will terminate the instances in OpenStack environment.
* `deletePuppetCert.py` execution is needed after every successful test run if you are
planning to use the same hostnames for the next test iteration.

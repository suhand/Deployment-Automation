#!/bin/bash

# With the addition of Keystone, to use an openstack cloud you should
# authenticate against keystone, which returns a **Token** and **Service
# Catalog**.  The catalog contains the endpoint for all services the
# user/tenant has access to - including nova, glance, keystone, swift.
#
# *NOTE*: Using the 2.0 *auth api* does not mean that compute api is 2.0.  We
# will use the 1.1 *compute api*

# --- Connection 1 ---
# This is the QAA new cloud URL
export OS_AUTH_URL=http://192.168.NN.NN:5000/v2.0
export OS_TENANT_ID=894343243245kj43543j2kuisdads
export OS_TENANT_NAME=“xxx”
export OS_USERNAME=“yyy”
export OS_PASSWORD=“yyy123”

# --- Connection 2 ---
# This is the QA cloud URL
#export OS_AUTH_URL=http://192.168.NN.XX:5000/v2.0
#export OS_TENANT_ID=xxxxxxxxxxxxxxxxxxxxxxx
#export OS_TENANT_NAME=“xx”
#export OS_USERNAME=“xxxx”
#export OS_PASSWORD=“xxxx”

# --- Connection 3 ---
# Stratos cloud support lab auth url
#export OS_AUTH_URL=http://192.168.KK.JJ:5000/v2.0

# --- Connection 4 ---
# WSO2 Internal IaaS auth url
# currently this auth url having issues
# following is the public ip given to access
#export OS_AUTH_URL=http://203.94.NN.ZZ:5000/v2.0

# With the addition of Keystone we have standardized on the term **tenant**
# as the entity that owns the resources.
#export OS_TENANT_ID=cc9383d8a04f40988f2fcf8aab397551
#export OS_TENANT_NAME=“xxxxx”

# In addition to the owning entity (tenant), openstack stores the entity
# performing the action as the **user**.
#export OS_USERNAME=“xxxxx”

# With Keystone you pass the keystone password.
#echo "Please enter your OpenStack Password: "
#read -sr OS_PASSWORD_INPUT
#export OS_PASSWORD=“xxxxx”



#!/bin/bash

# With the addition of Keystone, to use an openstack cloud you should
# authenticate against keystone, which returns a **Token** and **Service
# Catalog**.  The catalog contains the endpoint for all services the
# user/tenant has access to - including nova, glance, keystone, swift.
#
# *NOTE*: Using the 2.0 *auth api* does not mean that compute api is 2.0.  We
# will use the 1.1 *compute api*

# --- Connection 1 ---
# This is the QA cloud URL
export OS_AUTH_URL=http://192.168.16.85:5000/v2.0
export OS_TENANT_ID=dc85ffe397d6473cb73473ab68d7201d
export OS_TENANT_NAME="qa"
export OS_USERNAME=“su”
export OS_PASSWORD=“*********”

# --- Connection 2 ---
# Stratos cloud support lab auth url
#export OS_AUTH_URL=http://192.168.16.99:5000/v2.0

# --- Connection 3 ---
# WSO2 Internal IaaS auth url
# currently this auth url having issues
# following is the public ip given to access
#export OS_AUTH_URL=http://203.94.95.130:5000/v2.0

# With the addition of Keystone we have standardized on the term **tenant**
# as the entity that owns the resources.
#export OS_TENANT_ID=cc9383d8a04f40988f2fcf8aab397551
#export OS_TENANT_NAME="Stratos"

# In addition to the owning entity (tenant), openstack stores the entity
# performing the action as the **user**.
#export OS_USERNAME=“lasie”

# With Keystone you pass the keystone password.
#echo "Please enter your OpenStack Password: "
#read -sr OS_PASSWORD_INPUT
#export OS_PASSWORD=“*********”



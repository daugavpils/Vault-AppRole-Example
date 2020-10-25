# Install vault in k8s

https://learn.hashicorp.com/tutorials/vault/kubernetes-minikube?in=vault/kubernetes

# Vault config

### Mount an Approle 'appGDL'. 
```
vault auth enable approle
```

### Create new policy for App called appGDL
```
# list policies
vault  policy list

vault policy write appGDL - <<EOF
 path "GDL/Demo/*" {
     capabilities = ["create", "read", "update", "list" ]
 }
EOF

# read policy 
vault policy read appGDL
```

### Create approle for DemoApp
```
vault write auth/approle/role/appGDL bind_secret_id=true, policies="appGDL"

#bind_secret_id (bool: true) - Require secret_id to be presented when logging in using this AppRole.

# list it
vault read auth/approle/role/appgdl
```

### Setup Jenkins as Trusted Entity 1 ( Role ID)
```
# Create a policy for roleID
vault policy write trusted-entity-roleid - <<EOF
path  "auth/approle/role/*" {
    capabilities = ["read"]
}
EOF

# Create token
vault write auth/token/create display_name=jenkins policies=trusted-entity-roleid

# list tokens accessors
vault list auth/token/accessors

```

# Setup Ansible as Trusted Entity 2 ( Secret ID)
```
# Create a policy for Secret ID
vault policy  write trusted-entity-secretid - <<EOF
path "auth/approle/role/*" {
    capabilities = ["create","update"]
}
EOF

# Create Token
vault write auth/token/create display_name=jenkins policies=trusted-entity-secretid
```
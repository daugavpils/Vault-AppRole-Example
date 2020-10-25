export VAULT_TOKEN=s.Rpft5hTluhKkdVysMy1NWVTj

curl -X POST http://localhost:8200/v1/auth/approle/role/appGDL -H "X-Vault-Token:$VAULT_TOKEN" -d '{"bind_secret_id": "true", "policies": "appGDL"}'
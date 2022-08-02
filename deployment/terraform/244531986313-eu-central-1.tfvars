env          = "staging"
app_domain_names_list  = ["beta.cyber-dojo.org"]

# Allow to replicate app docker images to these accounts
ecr_replication_targets = [
  {
    "account_id" = "274425519734",
    "region"     = "eu-central-1"
  }
]

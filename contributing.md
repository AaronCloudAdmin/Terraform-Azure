cd path/to/your-terraform-folder

# 1. Ensure you're up to date on main before branching
git checkout main
git pull origin main

# 2. Create and switch to the new feature branch
git checkout -b feature/thing

# 3. Terraform pre-flight checks - stop and fix if any step errors
terraform fmt -recursive
terraform init
terraform validate
terraform plan -var-file="environments/dev.tfvars"
# review the plan output carefully before proceeding
terraform apply -var-file="environments/dev.tfvars"

# 4. Stage, commit, and push
git add .
git commit -m "feat: add thing"
git push -u origin feature/thing

# 5. Open PR on GitHub (base: main, compare: feature/thing), review diff, merge
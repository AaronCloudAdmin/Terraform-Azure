## Development Workflow

Before starting, ensure you are in the correct working directory:

cd path/to/your-terraform-folder

1. Sync the Local Environment
Ensure you are up to date on the main branch before creating a new feature branch.

git checkout main
git pull origin main

2. Create a Feature Branch
Create and switch to a new branch for your upcoming changes.

git checkout -b feature/your-feature-name

3. Validate Locally
Run pre-flight checks to format, initialize, and validate the configuration. Review the plan output carefully. Stop and fix any errors before proceeding. Do not apply the changes yet.

terraform fmt -recursive
terraform init
terraform validate
terraform plan -var-file="environments/dev.tfvars"

4. Stage, Commit, and Push
Once the plan executes perfectly, commit your changes and push the branch to the remote repository.

git add .
git commit -m "feat: your descriptive commit message"
git push -u origin feature/your-feature-name

5. Open a Pull Request
Open a PR on GitHub (base: main, compare: feature/your-feature-name).

Review the code differences, gain approval, and merge the PR into main.

6. Deploy to Azure
Once the PR is merged, return to your local terminal to pull the approved code and deploy the infrastructure.

git checkout main
git pull origin main
terraform apply -var-file="environments/dev.tfvars"

7. Clean Up Workspace
Delete your local feature branch and prune outdated remote references so you are ready for the next task.

git branch -d feature/your-feature-name
git fetch --prune

## Development Workflow

Before starting, ensure you are in the correct working directory:

cd path/to/your-terraform-folder

1. Sync the Local Environment
Always start from the most up-to-date version of main to avoid working from stale files.

git status
git checkout main
git pull origin main


2. Branch and Validate
Now make your .tf edits in VS Code. Nothing before this point should touch any files — always branch first, so new/edited files are never at risk of landing on the wrong branch.

git checkout -b feature/thing

3. Validate locally
Run each of these in order, and stop to fix anything that errors before moving to the next:

terraform fmt -recursive
terraform init
terraform validate
terraform plan -var-file="environments/dev.tfvars"

4. Deploy and test
Review the plan one more time when it re-displays, then type yes. Apply before committing — you want to confirm the code actually works against real Azure before it becomes part of your commit history, not after.

terraform apply -var-file="environments/dev.tfvars" 
git status
git add .
git commit -m "feat: add thing"
git push -u origin feature/thing

5. Stage, commit, and push

git status
git add .
git commit -m "feat: add thing"
git push -u origin feature/thing
	
6. Review and merge on GitHub
	• Navigate to the repository on GitHub.com.
	• Click Compare & pull request for your branch.
	• Review the diff yourself — this is the last checkpoint for anything like a stray hardcoded value or a leftover default.
	• Click Merge pull request.
	

7. Sync local main
git checkout main
git pull origin main


#-----------------------------------------------------------------

After the Pull Request:

1. Delete the Local Feature Branch
Since your code is safely merged into main, you no longer need the local copy of the feature branch. Ensure you are currently on main before running this.

git branch -d feature/thing
git fetch --prune



2. Verify Your Status
Ensure you are sitting cleanly on main with no lingering changes before starting your next body of work.

git status


To verify: It should say On branch main, Your branch is up to date with 'origin/main', and nothing to commit, working tree clean.
You are now completely reset. When you are ready to start your next task, you can immediately run git checkout -b feature/next-thing



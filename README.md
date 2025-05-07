# myapp

A new Flutter project.

## Git Annexe  
after cloning the project in your pc  
-> check if any origin already exist with `git remote -v`  
+ if an origin already exist do : `git remote remove origin`  
+ if there is no origin :  
`git init`  
`git remote add origin https://gitlab.com/examenti_app/examenti_app.git`  
(now as that's your first commit you have to create a sub branch )  
`git checkout -b your-new-branch-name`  
`git add .`  
`git commit -m "your commit message"`  
`git push -u origin your-new-branch-name`  
-> then directly open the GitLab space in your browser, go to the home page of the project and you'll find a notification of a merge request  
choose me as a reviewer and controller and disable the choice of delete branch after merging  
-> As first step when start working run this command to update the local project in your pc from the remote repo  
`git pull origin main
` 
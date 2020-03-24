# GIT WORKFLOW

Make sure to commit early and commit often. Commit messages should be meaningful (clearly describe what you're doing in the commit) and accurate (there should be nothing in the commit that doesn't match the description in the commit message). Good rule of thumb is to commit every 3-7 mins of actual coding time. Most of your commits should have under 15 lines of code and a 2 line commit is perfectly acceptable.

## STEPS

    -create a new branch of the feature you war working on
    -add lines of code often then
    -save that code locally using git commit -m "message about feature"
    -pull to ensure that your master branch is up-to-date
    

### BRANCH

Checkout and create a new branch. <filename> Should be named after the feature you are working on (ie 'Card Model')

```git checkout -b <filename>```

Use to view all the branches and which branch you are currently working on.

```git branch```

Change branches

```git checkout <branch-name>```

Deleting a branch that has been merged

```git branch -d <branch-name>```

```git branch -D <branch-name>``` ***use only if you are sure all your code has been merged

### COMMIT

Prep all changes within a current branch for commit

```git add .```

Prep changes in a certain file or directory for commit

```git add <filename>```

Check the status after you add

```git status```

Commit(save) changes with a message

```git commit -m "breif message describing what you are saving"```

### REMOTE

Check the remote address you have linked

```git remote -v```

IF you don't have the origin already set (for some reason)

```git remote add origin git@github.com:Tr1ckC0/ruby-project-guidelines-austin-web-030920.git```





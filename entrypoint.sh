#!/bin/bash

# Checks out each of your branches 
# copies the current version of 
# certain files to each branch

echo "==================================="

git config --global user.name "${GITHUB_ACTOR}"
git config --global user.email "${INPUT_EMAIL}"
git config --global --add safe.directory /github/workspace

args_key="${key}"
args_files="${files}"
args_branches="${branches}"
args_exclude="${exclude}"

if [ ! -z "${args_exclude}" ];
then
  EXCLUDE_BRANCHES=( "${args_exclude[@]}" )
fi

# Set default list of branches to use
if [ ! -z "${args_branches}" ];
then
	ALL_THE_BRANCHES=( "${args_branches[@]}" )
else
  ALL_THE_BRANCHES=`git branch -r --list|sed 's/origin\///g'`
fi

# Set the KEY branch
if [ ! -z "${args_key}" ];
then
	KEY_BRANCH=$args_key
elif [[ $ALL_THE_BRANCHES[*]} =~ 'master' ]];
then
  KEY_BRANCH='master'
elif [[ $ALL_THE_BRANCHES[*]} =~ 'main' ]];
then
  KEY_BRANCH='main'
else
	echo "Error: A key branch does not exist"
 	exit 1
fi

# Set default list of files to copy
if [ ! -z "${args_files}" ];
then
	ALL_THE_FILES=( "${args_files[@]}" )
else
  ALL_THE_FILES=('LICENSE' 'NOTICE' 'README.md')
fi

# Loop through the array of branches and perform
# a series of checkouts from the KEY_BRANCH 
for CURRENT_BRANCH in ${ALL_THE_BRANCHES[@]};
  do

    # Exclude branches if user has specified an exclusion list    
    for EXCLUDE_BRANCH in ${EXCLUDE_BRANCHES[@]}
      do
        if [ "$CURRENT_BRANCH" = "$EXCLUDE_BRANCH" ];
        then
          continue 2
        fi
      done

    echo "-------------------------------"
    
    # Check out the current branch, but only if
    # the branch is NOT the same as the key branch
    if [ "${KEY_BRANCH}" != "${CURRENT_BRANCH}" ];
    then
      echo "--GIT FETCH origin"
      git fetch origin
      echo "--GIT CHECKOUT -b $CURRENT_BRANCH origin/$CURRENT_BRANCH"
      git checkout -b $CURRENT_BRANCH origin/$CURRENT_BRANCH

      # Go through each of the files
      # Check out the selected files from the source branch
      for CURRENT_FILE in ${ALL_THE_FILES[@]};
        do
          echo "--GIT CHECKOUT $KEY_BRANCH -- $CURRENT_FILE"
          git checkout $KEY_BRANCH -- $CURRENT_FILE
        done

      # Commit the changes
      git add -A && git commit -m "Moving files $args_files using $KEY_BRANCH"

      # push the branch to the repository origin
      git push --set-upstream origin $CURRENT_BRANCH
    fi
  done

# Check out the key branch
git checkout $KEY_BRANCH

echo "==================================="

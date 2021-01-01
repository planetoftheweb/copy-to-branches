# Copy To Branches Action/Shell Script

This action runs a shell script in the `entrypoint.sh` file that lets you copy one or more files from a **key** branch to any other branches in your repo. By default, it copies **LICENSE**, NOTICE and README.md from the main branch to all branches on repository.

# Optional Arguments

## Key Branch `-k opts`
This is the key branch that you're using as the origin, in other words, the branch you want to copy from. If you don't include this, it will assume that you want to use a branch called `main` or `master`.

```bash
sh entrypoint.sh -k BRANCHNAME
```

## Files to Copy `-f opts`
By default, the script assumes you want to copy the `LICENSE`, `NOTICE` and `README.md` files. If you want to change this, you can pass along a different list of files to use instead.

```
sh entrypoint.sh -f FILENAME
```

If you want to pass more than one file, you can use a list of files in quotations.

```
sh entrypoint.sh -f "FILE01 FILE02 FILE03..."
```

## Branches to Copy to `-b opts`
By default, the script assumes you want to copy the files to all the branches in the repo. If you want to copy the files to only certain branches, then you can include this option.

```
sh entrypoint.sh -b "BRANCH01 BRANCH02..."
```

:warning: When you add a custom branch list, if you don't include a `main` or `master` branch in your list, the script wont run because it won't have a key branch to copy to.

You can easily add a key branch with the `-k` option.

```
sh entrypoint.sh -b "BRANCH01 BRANCH02" -k main
```

## Branches to Exclude `-e opts`
By default, the script will copy the files to all branches. You can exclude one or more branches by creating a list of branches to exclude.

```
sh entrypoint.sh -e "BRANCH01 BRANCH02"
```

## Push Branches `-p`
The script will make the changes, but not push them to your repo. This option will set the  push the files to your repo and also set the upstream origin to the current branch.

```
sh entrypoint.sh -p
```

It uses the following command in the `entrypoint.sh` file.

```
git push --set-upstream origin $CURRENT_BRANCH
```
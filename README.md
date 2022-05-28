# Copy To Branches Action/Shell Script

This action runs a shell script `entrypoint.sh` file which lets you copy one or more files from a **key** branch to any other branches in your repo. By default, it copies **LICENSE**, **NOTICE** and **README.md** from the main/master branch to all branches on repository.

# Running this action
1. Go to your repo
2. Click on the **Actions** tab

![Click on Actions Tab](http://pixelprowess.com/i/2021-01-07_01-38-46.png)

3. Click on the **Set up a workflow yourself** link

![Set up a workflow yourself link](http://pixelprowess.com/i/2021-01-07_01-39-53.png)

4. Use the following script.

```yaml
name: Copy To Branches
on:
  workflow_dispatch:
jobs:
  copy-to-branches:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
        with:
          fetch-depth: 0
      - name: Copy To Branches Action
        uses: planetoftheweb/copy-to-branches@v1
```

5. Click the **Start commit** button

![Start Commit Button](http://pixelprowess.com/i/2021-01-07_01-49-18.png)

6. Click back on the **Actions** tab
7. Click on the **Copy To Branches** workflow
8. Click on **Run Workflow**

![](http://pixelprowess.com/i/2021-01-07_01-52-54.png)

The workflow should run automatically, you can monitor it if you want to.

# Optional Arguments

By default, the action will try to copy the  **LICENSE**, **NOTICE** and **README.md** files from the main/master branch to all branches, but you can modify the behavior by adding a list of arguments in an `env` variable.

## Example

```yaml
name: Copy To Branches
on:
  workflow_dispatch:
jobs:
  copy-to-branches:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
        with:
          fetch-depth: 0
      - name: Copy To Branches Action
        uses: planetoftheweb/copy-to-branches@v1
        env:
          key: main
          exclude: work 99_target
          files: README.md
```

Using the key branch named `main` This will copy only the `README.md` file to all branches, but skip two branches, one named `work` and one called `99_target`.

## Key
This is the key branch that you're using as the origin, in other words, the branch you want to copy from. By default, you should include `main` here, but you can ask for a different branch to copy from. Say you wanted to copy files from the branch named `02_03b` to all branches. You would use:

```yaml
env:
  key: 02_03b
```

## Files to copy
By default, the script assumes you want to copy the `LICENSE`, `NOTICE` and `README.md` files. If you want to change this, you can pass along a different list of files to use instead. Use the `files` keyword and then pass a list of one or more branches separated by spaces.

```yaml
env:
  files: README.md NOTICE
```

## Branches to Copy
By default, the script assumes you want to copy the files to all the branches in the repo. If you want to copy the files to only certain branches, then you can include this option.

```yaml
env:
  branches: 02_03b 02_03e 02_04b
  key: main
```

:warning: When you add a custom branch list, if you don't include a `main` or `master` branch in your list, the script wont run because it won't have a key branch to copy to.

You can easily add a key branch with the `key` option.

## Branches to Exclude
By default, the script will copy the files to all branches. You can exclude one or more branches by creating a list of branches to exclude.

```yaml
env:
  exclude: target gh-pages
```
# Sync Git Branch Action

A GitHub Action for synchronizing a git branch to another location via SSH.

## Inputs

| Name                 | Description                               | Default                             | Required |
| -------------------- | ----------------------------------------- | ----------------------------------- | -------- |
| `source-branch`      | Branch name in the source repository      |                                     | Yes      |
| `destination-repo`   | SSH URL of the destination repository     |                                     | Yes      |
| `source-repo`        | SSH URL of the source repository          | The respository this action runs in | No       |
| `destination-branch` | Branch name in the destination repository | Same as `source-branch`             | No       |

## Environment variables

`SSH_PRIVATE_KEY`: Create a [SSH key](https://help.github.com/en/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent#generating-a-new-ssh-key) **without** a passphrase which has access to both repositories.

On GitHub you should add the public key to repository "deploy keys". 

Store [the private key as a secret](https://help.github.com/en/actions/configuring-and-managing-workflows/creating-and-storing-encrypted-secrets) and use it in your workflow as seen in the example usage below.

## Example workflow

```yml
name: Sync main branch to Bitbucket

on: [push, delete, create]

jobs:
  git-mirror:
    runs-on: ubuntu-latest
    steps:
      - uses: zent-contrib/git-branch-sync-action@v1
        env:
          SSH_PRIVATE_KEY: ${{ secrets.SSH_PRIVATE_KEY }}
        with:
          source-branch: main
          destination-repo: "git@bitbucket.org:<org>/<repo>.git"
```
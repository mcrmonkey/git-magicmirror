# Git MagicMirror

POC for maintaining repository a mirror.

Currently defaults to handling the master branch but others can be added if needed.

**Use at your own risk**: This is a proof of concept and may break something

Can be run via the docker image or the script run directly on your host system
( Working directory defaults to /workspace )

*Note*: For ease some host keys have been included for github, gitlab and
bitbucket. You may have to accept some host keys during the clone process.

## Building the container

Standard build process for a container:

```bash
docker build -t git-magicmirror .

```

## Running in the container


### Required Variables

The following environment variables are required to run:

`SOURCE_GIT` - is the clone URL for the repo you wish to mirror

`MIRROR_GIT` - is the clone URL for the mirror repository

An example clone URL may look like this for SSH: `git@github.com:mcrmonkey/.files.git`

or this for HTTPS: `https://github.com/mcrmonkey/.files.git`

Obviously you'll need to be able to push mirror repo to update it.

### Optional variables

Setting the environment variable `AUTO_PUSH` to any value will trigger an
attempt to push the changes back to the mirror repo.

### SSH authentication

You can pass in ssh keys with a docker volume option:

`-v /path/to/key:/root/.ssh/id_rsa:ro`

or you can pass your current SSH agent through:

`-v ${SSH_AUTH_SOCK}:/sshsock:ro -e SSH_AUTH_SOCK="/sshsock"`


Example Docker command:

```bash

docker run -it --rm --name git-magicmirror -e SOURCE_GIT="<source-repo>" -e
MIRROR_GIT="<mirror-repo>"

```

You can add `/go.sh` to the end of the docker run command to trigger the
process as soon as the container starts.

## Other options 

the `/workspace` directory can be moved to a volume if you wish to keep the
repository data you're working on




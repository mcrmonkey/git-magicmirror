#!/bin/bash

## quit on error
set -e

if [ -z ${SOURCE_GIT+x} ]
then
	echo "SOURCE_GIT env variable is not set. This is required!"
	exit 2
fi

if [ -z ${MIRROR_GIT+x} ]
then
	echo "MIRROR_GIT env variable is not set. This is required!"
	exit 2
fi

cd /workspace

echo -ne "\n---- [i] Setting up local git repo ----\n\n"

mkdir git && cd git

git init


echo -ne "\n---- [i] Adding source repo: ${SOURCE_GIT} ----"

git remote add source ${SOURCE_GIT}

echo -ne "\n---- [i] Adding mirror repo: ${MIRROR_GIT} ----"
git remote add mirror ${MIRROR_GIT}


echo -ne "\n---- [i] Fetching everything ----\n\n"

git fetch --all


echo -ne "\n---- [i] Checkout master branch on the mirror ----\n\n"

git checkout -b mirror-master mirror/master

echo -ne "\n---- [i] Rebasing on source/master ----\n\n"
git rebase source/master



if [ -z ${AUTO_PUSH+x} ]
then
	echo -ne "\n---- [i] Ready to push! ----\ndo git push mirror HEAD:master when ready\n\n"
else
	echo -ne "\n---- [i] Pushing to mirror"
	git push mirror HEAD:master
fi






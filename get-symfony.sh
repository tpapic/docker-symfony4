#!/bin/bash
cd ../
url=$1;
reponame=$(echo $url | awk -F/ '{print $NF}' | sed -e 's/.git$//');
git clone $url $reponame;
cd docker-symfony4
echo "REPO_NAME=$reponame" > .env

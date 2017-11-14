#!/bin/bash

HOSTNAME=`hostname`
CONFIG_FILE=/etc/gitlab-runner/config.toml

rm -rf $CONFIG_FILE

if [ $TOKEN ]; then
	gitlab-runner register --non-interactive \
		--registration-token=$TOKEN \
		--executor='docker' \
		--url='https://gitlab.com' \
		--tag-list='' \
		--docker-image="$DOCKER_IMAGE" \
		--description="$HOSTNAME"
	cat $CONFIG_FILE
fi

for TOKEN in $REGISTERED_TOKENS
do
	cat >> $CONFIG_FILE <<EOF
[[runners]]
  name = "$HOSTNAME"
  url = "https://gitlab.com"
  token = "$TOKEN"
  executor = "docker"
  [runners.docker]
    tls_verify = false
    image = "$DOCKER_IMAGE"
    privileged = false
    disable_cache = false
    volumes = ["/cache"]
    shm_size = 0
  [runners.cache]

EOF
done

/usr/bin/gitlab-runner run --user=gitlab-runner --working-directory=/home/gitlab-runner

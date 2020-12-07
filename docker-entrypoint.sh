#! /bin/env bash

WORKDIR=/opt/runner

TOKEN=${GITHUB_TOKEN:-$(cat /run/github_token)}
if [ -z $TOKEN ]; then
    echo "error: expected either GITHUB_TOKEN variable or /run/github_token to be not empty"
    exit 1
fi

URL=${GITHUB_URL:-$(cat /run/github_url)}
if [ -z $URL ]; then
    echo "error: expected either GITHUB_URL variable or /run/github_url to be not empty"
    exit 1
fi

LABELS=${GITHUB_LABELS:-$(cat /run/github_labels)}
LABELS=self-hosted,$(uname -s),$(uaname -m),${LABELS}

${WORKDIR}/config.sh --unattended --url ${URL} --token ${TOKEN} --labels ${LABELS}

exec ${WORKDIR}/run.sh

#!/bin/sh

sh -c "docker "
curl -X POST -H 'Content-type: application/json' \
--data "{\"text\": \"$*\",\"attachments\":[{\"footer\": \"$GITHUB_ACTOR / $GITHUB_REPOSITORY / $GITHUB_SHA\"}]}" \
 $SLACK_WEBHOOK_URL

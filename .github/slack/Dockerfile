FROM debian:9.5-slim

RUN apt-get update -qq && apt-get install -y curl

ARG SLACK_WEBHOOK_URL
ARG GITHUB_ACTOR
ARG GITHUB_REPOSITORY
ARG GITHUB_SHA

LABEL "com.github.actions.name"="Slack notifier"
LABEL "com.github.actions.description"="Sends message to slack channel"
LABEL "com.github.actions.icon"="bell"
LABEL "com.github.actions.color"="yellow"

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

workflow "Test and deploy to heroku" {
  on       = "push"
  resolves = ["heroku.deploy"]
}

action "ruby.build" {
  uses = "actions/docker/cli@master"
  args = "build -f Dockerfile.test -t ci-$GITHUB_SHA:latest ."
}

action "ruby.rubocop" {
  uses = "actions/docker/cli@master"
  needs = ["ruby.build"]
  args = "run ci-$GITHUB_SHA:latest rubocop"
}

action "ruby.rspec" {
  uses = "actions/docker/cli@master"
  needs = ["ruby.build"]
  args = "run ci-$GITHUB_SHA:latest rspec"
}

action "git.master" {
  uses = "actions/bin/filter@master"
  needs = ["ruby.rubocop", "ruby.rspec"]
  args = "branch master"
}

action "heroku.login" {
  uses    = "actions/heroku@master"
  needs   = ["git.master"]
  args    = "container:login"
  secrets = ["HEROKU_API_KEY"]
}

action "heroku.push" {
  uses  = "actions/heroku@master"
  needs = "heroku.login"
  args  = ["container:push", "web"]

  secrets = [
    "HEROKU_API_KEY",
    "HEROKU_APP"
  ]

  env = {
    RACK_ENV = "production"
  }
}

action "heroku.envs" {
  uses  = "actions/heroku@master"
  needs = "heroku.push"

  args = [
    "config:set",
    "RACK_ENV=$RACK_ENV",
    "MY_SECRET=$MY_SECRET"
  ]

  secrets = [
    "HEROKU_API_KEY",
    "HEROKU_APP",
    "MY_SECRET"
  ]

  env = {
    RACK_ENV = "production"
  }
}

action "heroku.deploy" {
  uses  = "actions/heroku@master"
  needs = ["heroku.envs", "heroku.push"]
  args  = ["container:release", "web"]

  secrets = [
    "HEROKU_API_KEY",
    "HEROKU_APP",
    "MY_SECRET"
  ]

  env = {
    RACK_ENV = "production"
  }
}

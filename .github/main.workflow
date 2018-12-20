workflow "Production" {
  on = "push"
  resolves = ["heroku.deploy"]
}

action "heroku.deploy" {
  uses = "actions/heroku@master"
  needs = "heroku.push"
  args = "container:release web"
  secrets = ["HEROKU_API_KEY", "HEROKU_APP"]
  env = {
    RACK_ENV = "production"
  }
}

  action "heroku.push" {
    uses = "actions/heroku@master"
    needs = "heroku.login"
    args = "container:push web"
    secrets = ["HEROKU_API_KEY", "HEROKU_APP"]
  }

  action "heroku.login" {
    uses = "actions/heroku@master"
    args = "container:login"
    secrets = ["HEROKU_API_KEY", "HEROKU_APP"]
  }

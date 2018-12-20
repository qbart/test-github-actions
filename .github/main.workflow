workflow "Main" {
  on = "push"
  resolves = ["Deploy to heroku"]
}

action "Deploy to heroku" {
  uses = "actions/heroku@6db8f1c"
  env = {
    RACK_ENV = "production"
  }
  secrets = ["MY_SECRET"]
}

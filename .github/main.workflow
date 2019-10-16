workflow "Build and Test" {
  on = "push"
  resolves = ["Run cypress tests"]
}

action "Install dependencies" {
  uses = "actions/npm@master"
  runs = "npm install"
}

action "Build app" {
  uses = "actions/npm@master"
  needs = "Install dependencies"
  runs = "npm run build"
}

action "Run cypress tests" {
  uses = "docker://circleci/node:8-browsers"
  needs = "Build app"
  runs = "npm run cypress:run"
}
# global-registry-dataview

This project is also known as *Nebo*.

## Production [ ![Codeship Status for CruGlobal/global-registry-dataview](https://codeship.com/projects/c43536d0-331b-0133-d98c-22535d26ab7f/status?branch=master)](https://codeship.com/projects/100132)

[nebo.cru.digital](http://nebo.cru.digital/)

Hosted on AWS, via Cloud66.

### Deployment

You may deploy updates by pushing code to the `master` branch, if the tests pass then Codeship will initiate the deploy.

## Local Development Setup

1. `git clone git@github.com:CruGlobal/global-registry-dataview.git && cd global-registry-dataview`
2. Setup a Ruby environment corresponding to `.ruby-version`, using a tool like rvm or rbenv.
3. `bundle install`
4. Setup environment variables: `cp .env.sample .env && vim .env` You can generate a secret key base with `./bin/rake secret`. You will need a token for access to the Global Registry api.
5. `./bin/rake db:setup`
6. `./bin/rails server`

## Tests

Your code should be covered with some tests before it's published to GitHub.

Run all tests with `./bin/rake test`

Run a single test file with `./bin/rake test test/path/to/my_test.rb`

## Authentication

Authentication uses TheKey.me SSO service. TheKey.me is an implementation of the CAS protocol, so we use the gem [rack-cas](https://github.com/biola/rack-cas/) to handle this.

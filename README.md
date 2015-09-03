# global-registry-interface

This project is also known as *Nebo*.

## Local Development Setup

1. `git clone git@github.com:CruGlobal/global-registry-interface.git && cd global-registry-interface`
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

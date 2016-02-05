# Taggart, based on Sinatra Starter
## Program to show html source of document at url specified and provide tag counts and highlighting of tags

### uses a few common components:

- [Haml](http://haml.info/) (markup)
- [Sass](http://sass-lang.com/) (styling)
- [Coffeescript]() (javascript)
- [Bundler](http://bundler.io/) (package management)
- [Heroku Toolbelt](https://toolbelt.heroku.com/) (which gets you...)
  - [Heroku client](https://www.heroku.com/) (CLI tool for creating and managing Heroku apps)
  - [Foreman](https://github.com/ddollar/foreman) (An easy option for running your apps locally)
  - [Git](https://github.com) (revision control and pushing to Heroku)

### Installation

Clone this directory and change into it. Run `bundle` to install all dependencies.

### Running locally

Since Sinatra Starter is configured to deploy on Heroku, a `Procfile` is included.

    web: bundle exec ruby app.rb -p $PORT

Use `foreman start -p XXXX` on your port of choice. For example:

    foreman start -p 3000

### Testing

Using rspec

    bundle exec rspec


### Deploying

Configure an app for free on Heroku and follow their instructions on [deploying with Git](https://devcenter.heroku.com/articles/git).

# Cobudget API

[![Build Status](https://travis-ci.org/open-app/cobudget-api.svg?branch=master)](https://travis-ci.org/open-app/cobudget-api) [![Stories in Ready](https://badge.waffle.io/open-app/cobudget-api.png?label=ready&title=Ready)](https://waffle.io/open-app/cobudget-api)

Cobudget is a web app helping people collaborate on budgets. For more about the project as a whole, check out the [top-level repo](https://github.com/open-app/cobudget). This repo is the backend API of Cobudget.

#### Don't push to master - feature branches and pull requests please.

## How to...

### Install

Install ruby and gem: https://www.ruby-lang.org/en/installation/

```
git clone https://github.com/open-app/cobudget-api
cd cobudget-api
bundle install
```

### Configure

To configure database environments, edit `config/database.yml`.

### Setup database

*Setup and seed the db:*

```
bundle exec rake db:setup
```

### Run

*Start server:*

```
bundle exec rails s
```

### Test

*Test*

```
bundle exec rspec
```


[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/metadevfoundation/cobudget-api/trend.png)](https://bitdeli.com/free "Bitdeli Badge")


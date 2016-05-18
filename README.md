# Sinatra validations

[![Build Status](https://img.shields.io/travis/pedrogimenez/sinatra-validations/master.svg)](https://travis-ci.org/pedrogimenez/sinatra-validations)

I use this library to validate parameters in my Sinatra applications.

It supports defaults and type coercion.

## Install

```bash
$ gem "sinatra-validations"
```

## Usage

```ruby
require "sinatra/validations"

class Api < Sinatra::Base
  helpers Sinatra::Validations

  get "/users" do
    validate params, :sort, type: String, default: "desc"
    validate params, :limit, type: Integer, default: 30
    validate params, :filter_by, type: String, default: nil

    # ...
  end

  get "/users/:user" do
    validate params, :user, type: String

    # ...
  end
end
```

## Documentation

Read the tests.

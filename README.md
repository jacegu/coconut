#coconut   [![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/jacegu/coconut)

A coconfiguration tool for your Ruby projects.

![coconut for fun and profit](https://dl.dropbox.com/u/1130242/coconut.jpg)

## Installation

Add this line to your application's Gemfile:

    gem 'coconut'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install coconut


## What is coconut?
Coconut provides **a simple DSL that allows you to configure your application's
assets on different environments**

```ruby
require 'coconut'

Coconut.configure MyApp do
  twitter do
    environment :development do
      consumer_key     'development_key'
      consumer_secret  'development_secret'
    end

    environment :production do
      consumer_key     'production_key'
      consumer_secret  'production_secret'
    end
  end
end
```

You only need to require file from your app. Coconut will define a
`config` method on your application's namespace that you can use to query it.
**You don't have to specify the environment when querying for configuration
values**. Coconut will only run the configuration for the environment it's
running on.

```ruby
ENV['RACK_ENV'] = :development
MyApp.config.twitter.consumer_key       # => development_key

ENV['RACK_ENV'] = :production
MyApp.config.twitter.consumer_key       # => production_key
```

## Why coconut?
TODO


## Coconut flavours
TODO
### Single file
TODO

### Folder
TODO

### List of files
TODO


## How is the environment detected?
Right now coconut uses the environment variable `RACK_ENV` to detect the
environment the app is running on. If `RACK_ENV` is not set or is empty it
defaults to `:development`.

### Changing the environment
TODO

## Contributing
1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

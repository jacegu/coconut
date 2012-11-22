coconut
=======
A coconfiguration tool for your Ruby projects

![coconut for fun and profit](https://dl.dropbox.com/u/1130242/coconut.jpg)

## How it works

Coconut provides a simple DSL that allows you to set up your application's
configuration for different environments.

```ruby
require 'coconut'

Coconut.configure MyApp, :database do
  environment :development do
    adapter   'postgresql'
    host      'localhost'
    port      '5432'
    user      'jacegu'
    password  ''
  end

  environment :production do
    adapter   'postgresql'
    host      'domain.org/db'
    port      '5432'
    user      'jacegu'
    password  'xxxxxx'
  end
end
```

Then require the file from your app. Coconut will define a
`config` method on your application's namespace that you can use to query it.
**You don't have to specify the environment**, coconut will only run the
configuration for the environment it's running in:

```ruby
puts ENV['RACK_ENV']                #=> development
MyApp::config.database.host         #=> localhost
puts ENV['RACK_ENV'] = :production
MyApp::config.database.host         #=> domain.org/db
```

###Changing how the environment is detected
Right now coconut uses the environment variable `RACK_ENV` to detect the
environment the app is running on. If `RACK_ENV` is not set or is empty it
defaults to `development`.

In the future there will be a way of specifying how Coconut must find out
the environment it's running on.

###Splitting configuration into different files
TODO

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


## Overview
Coconut provides **a simple DSL that allows you to configure your application's
assets on different environments**.

```ruby
require 'coconut'

Coconut.configure MyApp do
  twitter do
    environments :development, :test do
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

You only need to require the config file from your app. Coconut will define a
`config` method on your application's namespace that you can use to query it.

```ruby
ENV['RACK_ENV'] = :development
MyApp.config.twitter.consumer_key       # => development_key

ENV['RACK_ENV'] = :production
MyApp.config.twitter.consumer_key       # => production_key
```

**You don't have to specify the environment when querying for configuration
values. Coconut will only run the configuration for the environment it's
running on.**


## How is the environment detected?
Coconut uses the `RACK_ENV` environment variable by default to detect the
environment the app is running on. If this variable is not set or is empty it
will default to `:development`.

If your ecosystem uses something that is not RACK based you can specify how
Coconut should find out the environment with the `take_environment_from` method 
on the **Application** level
(See the *Specifying how the environment should be found* section on
*Application* under *Coconut Anatomy*).


## Coconut Anatomy
Coconut is composed of **3 different parts**:

### 1) Application
*Application is the top level block* of Coconut. It's composed of the configuration
of the *Assets* your application has. It may also contain information about
where Coconut should look for *Asset* configuration files and how it should
find out which environment the application is running on.

You will enter this block when you call the `Coconut.configure` method passing
in your application's namespace.

```ruby
require 'coconut'

Coconut.configure MyApp do
  # your application configuration
end
```

Coconut will then detect the environment,
run the configuration and create a `Coconut::Config` object with the assets
and it's properties for the current environment. A `config` method will be
defined in the namespace passed to `configure`. That method will return the
`Coconut::Config` object with your application's configuration.

That means:
* You only need to make sure that you require the config file that includes the
  *Application* block for your configuration to be run.
* Your configuration will be run just once (unless you use `Kernel::load`)
* If there is a `config` method on your namespace it will be overriden.
* You will be able to access the configuration from anywhere by calling
  `Namespace::config`.

#### Specifying how the environment should be found
If your application should not use the RACK_ENV environment variable to
determine which configuration to use you can tell Coconut how to find out:

```ruby
Coconut.configure MyApp do
  take_environment_from { MyApp::find_out_environment }
  # ...
end
```

Coconut will call the block passed to the `environment` method to find out
what environment the application is running on. Therefore **the environment
will be the return value of that block**.


#### Coconut flavours (how to structure your configuration).
You can structure the configuration in several ways with coconut. See
[coconut flavours](https://github.com/jacegu/coconut/wiki/Coconut-flavours--\(how-to-split-your-configuration\))
in the wiki.

### 2) Asset
Each of this blocks represent one of the assets of your application. Inside
each one of them you will include the *Asset* properties on each of the
environments your application will run on.

An *Asset* block consist of the asset name and a Ruby block containing it's
configuration in each of the environments:

```ruby
asset_name do
  environment(:production)         { property 'value on production' }
  environment(:development, :test) { property 'value on test and development' }
end
```

You can specify one or more environments at the same time. You can also use any
of the aliases the `environment` method has:

```ruby
env(:development, :test)          { property 'value' }
envs(:development, :test)         { property 'value' }
environment(:development, :test)  { property 'value' }
environments(:development, :test) { property 'value' }
```

An *Asset* can have *almost* any name. There are some restrictions that apply to
the names. This restrictions apply to both asset names and property names
and are explained in the *Environment* section of this README.

### 3) Environment
Environments are the lowest level of a Coconut configuration. Its composed of
the configuration properties an asset will have on that environment. So,
essentially, it's a series of key-value pairs.

Properties can have almost any name you can think of. It only has to be a valid
Ruby method name and you have to avoid those that will collide with calls on
the `Config` object. Coconut will raise an error if you use one of the reserved
names:

```ruby
environment(:development) { object_id 11 }
# => Coconut::Dsl::InvalidName: object_id can't be used as property name: it will collide with Coconut::Config methods
```

You can find out the forbidden property (and asset) names by calling the method:
```ruby
Coconut::Dsl::BlankSlate.__forbidden_names
# => [:respond_to?, :to_hash, :nil?, :===, :=~, :!~, :eql?, :hash, :<=>, :class, :singleton_class, :clone, :dup,
#     :initialize_dup, :initialize_clone, :taint, :tainted?, :untaint, :untrust, :untrusted?, :trust, :freeze,
#     :frozen?, :to_s, :inspect, :methods, :singleton_methods, :protected_methods, :private_methods,
#     :public_methods, :instance_variables, :instance_variable_get, :instance_variable_set,
#     :instance_variable_defined?, :instance_of?, :kind_of?, :is_a?, :tap, :send, :public_send,
#     :respond_to_missing?, :extend, :display, :method, :public_method, :define_singleton_method, :object_id,
#     :to_enum, :enum_for, :==, :equal?, :!, :!=, :instance_eval, :instance_exec, :__send__, :__id__,
#     :instance_eval, :__send__, :object_id, :__taken?, :__taken_error_message]
```

If you want to use the methods from `Kernel` that are widely available
on Ruby objects you will need to prepend the module to the method call:

```ruby
environment(:development) do
  puts 'here'         # declaring a property named "puts"
  Kernel::puts 'here' # printing "here" to STDOUT
end
```

Values can be any Ruby object, from a simple integer or string to a lambda.
You can even use constant or expressions. Keep in mind that the block passed
to environment will be evaluated in a different context:
you won't be able to call methods without specifying their receiver.

```ruby
environment :development do
  four      2 + 2
  arguments ARGV
  encodings Encoding.list
  setup -> do
    enable  :sessions, :logging
    disable :dump_errors, :some_custom_option
  end
end
```

## Why coconut?
TODO

## Contributing
1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

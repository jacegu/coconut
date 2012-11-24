require_relative 'coconut/version'
require_relative 'coconut/config'

module Coconut
  def self.configure(namespace, &assets)
    raise "#{namespace} already has a config method" if namespace.respond_to? :config
    define_config_method namespace, Config.new(current_environment, &assets)
  end

  def self.current_environment
    ENV['RACK_ENV'] || :development
  end

  private

  def self.define_config_method(namespace, configuration)
    singleton_class_of(namespace).instance_eval do
      define_method :config do
        @_coconut_configuration ||= configuration
      end
    end
  end

  def self.singleton_class_of(class_or_module)
    class << class_or_module; self; end
  end
end

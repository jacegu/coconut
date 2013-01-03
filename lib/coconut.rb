require_relative 'coconut/version'
require_relative 'coconut/dsl/application'

module Coconut
  include Dsl

  def self.configure(namespace, &config)
    define_config_method namespace, Application.configure(environment, &config)
  end

  def self.environment
    return @_coconut_environment.() unless @_coconut_environment.nil?
    ENV['RACK_ENV'] || :development
  end

  def self.take_environment_from(&block)
    @_coconut_environment = block
  end

  private

  def self.define_config_method(namespace, configuration)
    namespace.singleton_class.instance_eval do
      define_method(:config) { @_coconut_configuration ||= configuration }
    end
  end
end

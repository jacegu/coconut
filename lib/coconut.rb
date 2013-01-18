require_relative 'coconut/version'
require_relative 'coconut/dsl/application'

module Coconut
  include Dsl

  def self.configure(namespace, &config)
    config = Application.configure(environment, &config)
    define_config_method(namespace, config)
    define_config_constant(namespace, config)
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

  def self.define_config_constant(namespace, configuration)
    namespace.instance_eval do
      remove_const('Config') if const_defined?('Config', false)
      const_set('Config', configuration)
    end
  end
end

require_relative 'coconut/version'
require_relative 'coconut/dsl/application'

module Coconut
  include Dsl

  def self.included(base)
    configure_method = method(:configure)
    base.singleton_class.instance_eval do
      define_method(:configure) { |*args, &block| configure_method.(base, &block) }
    end
  end

  def self.configure(namespace, &config)
    config = Application.configure(environment, &config)
    check_for_unconfigured_assets(config)
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
      remove_const(:CONFIG) if const_defined?(:CONFIG, false)
      const_set(:CONFIG, configuration)
    end
  end

  def self.check_for_unconfigured_assets(config)
    config.to_hash.each do |asset, properties|
      Kernel.warn "WARNING: \"#{asset}\" asset has no properties set up for \
                   current environment (#{environment})" if properties.empty?
    end
  end
end

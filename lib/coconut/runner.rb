require_relative 'config'
require_relative 'dsl/blank_slate'
require_relative 'dsl/environment'

module Coconut
  class Runner
    def initialize(current_environment)
      @current_environment = current_environment
      @config = {}
    end

    def run(&config)
      instance_eval &config
      Config.new(@config)
    end

    private

    def method_missing(name, *args, &block)
      @config[name] = AssetRunner.new(@current_environment).run(&block)
    end
  end

  class AssetRunner
    def initialize(current_environment)
      @current_environment = current_environment
    end

    def run(&config)
      instance_eval &config
      @config
    end

    private

    def environment(environment, &environment_config)
      @config = Dsl::Environment.run(&environment_config) if current? environment
    end

    def current?(environment)
      @current_environment.to_sym == environment.to_sym
    end
  end
end

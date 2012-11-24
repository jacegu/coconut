require 'delegate'
require 'hashie'
require_relative 'asset'
require_relative 'runner'

module Coconut
  class Config < DelegateClass(Hashie::Mash)
    def initialize(current_environment, &assets_config)
      super Hashie::Mash.new
      run assets_config, current_environment
    end

    private

    def run(config, environment)
      Runner.new run: config, method_missing: configure_asset_on(environment)
    end

    def configure_asset_on(environment)
      ->(name, *args, &config){ self[name] = Asset.new(environment, &config) }
    end
  end
end

require 'coconut/dsl/asset'

describe Coconut::Dsl::Asset do
  it 'creates the asset config for the given environment' do
    asset_config = described_class.configure(:current) do
      environment(:other)   { property 'value in other' }
      environment(:current) { property 'value in current' }
    end
    asset_config.fetch(:property).should eq 'value in current'
  end

  it 'can setup different environments at the same time' do
    asset_config = described_class.configure(:current) do
      environment(:other, :current) { property 'value in other and current' }
    end
    asset_config.fetch(:property).should eq 'value in other and current'
  end

  it 'can setup environments step by step' do
    asset_config = described_class.configure(:current) do
      environment(:other, :current) { property 'value in other and current' }
      environment(:other)   { thing 'thing in other' }
      environment(:current) { thing 'thing in current' }
    end
    asset_config.fetch(:property).should eq 'value in other and current'
    asset_config.fetch(:thing).should eq 'thing in current'
  end

  it 'allows properties to be overriden' do
    asset_config = described_class.configure(:current) do
      environment(:other, :current) { property 'value in other and current' }
      environment(:current) { property 'only in current' }
    end
    asset_config.fetch(:property).should eq 'only in current'
  end

  it 'has alternate ways of configuring an environment' do
    asset_config = described_class.configure(:current) do
      env(:current)          { property1 1 }
      environment(:current)  { property2 2 }
      environments(:current) { property3 3 }
      envs(:current)         { property4 4 }
    end
    asset_config.fetch(:property1).should eq 1
    asset_config.fetch(:property2).should eq 2
    asset_config.fetch(:property3).should eq 3
    asset_config.fetch(:property4).should eq 4
  end
end

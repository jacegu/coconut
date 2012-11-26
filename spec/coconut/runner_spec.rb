require 'coconut/runner'

describe Coconut::Runner do
  it 'creates the config for every asset' do
    config = described_class.new(:current).run do
      asset { environment(:current) { property 'value' } }
    end
    config.asset.property.should eq 'value'
  end
end

describe Coconut::AssetRunner do
  it 'creates the asset config for the given environment' do
    config = described_class.new(:current).run do
      environment(:other)   { property 'value in other' }
      environment(:current) { property 'value in current' }
    end
    config.property.should eq 'value in current'
  end
end

describe Coconut::EnvironmentRunner do
  it 'creates the environment config' do
    config = described_class.run do
      property 'value'
      other    'other'
    end
    config.property.should eq 'value'
    config.other.should eq 'other'
  end
end

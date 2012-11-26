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

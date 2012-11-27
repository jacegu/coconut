require 'coconut/dsl/application'

describe Coconut::Dsl::Application do
  it 'creates the config for every asset' do
    config = described_class.new(:current).run do
      asset { environment(:current) { property 'value' } }
    end
    config.asset.property.should eq 'value'
  end
end

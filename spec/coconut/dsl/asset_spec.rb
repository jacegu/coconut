require 'coconut/dsl/asset'

describe Coconut::Dsl::Asset do
  it 'creates the asset config for the given environment' do
    config = described_class.new(:current).run do
      environment(:other)   { property 'value in other' }
      environment(:current) { property 'value in current' }
    end
    config.property.should eq 'value in current'
  end
end

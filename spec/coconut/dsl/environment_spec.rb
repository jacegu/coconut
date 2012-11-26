require 'coconut/dsl/environment'

describe Coconut::Dsl::Environment do
  it 'creates the environment config' do
    config = described_class.run do
      property 'value'
      other    'other'
    end
    config.property.should eq 'value'
    config.other.should eq 'other'
  end
end

require 'hashie'
require 'coconut/environment'

describe Coconut::Environment do
  it 'collects method calls as configuration values' do
    config = described_class.new { property 'value' }
    config.should have_key :property
    config.property.should eq 'value'
  end

  it 'can have (almost) any property name' do
    config = described_class.new do
      __id__  11
      equal?  33
      inspect 'CoconutJuice'
    end
    config.fetch('__id__').should eq 11
    config.fetch('equal?').should eq 33
    config.fetch('inspect').should eq 'CoconutJuice'
  end
end

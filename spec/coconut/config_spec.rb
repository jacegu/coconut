require 'coconut/config'

describe Coconut::Config do
  subject          { described_class.new(properties) }
  let(:properties) { Hash[property: 'value', other: 'other'] }

  context 'newly created' do
    it 'has no property methods' do
      (subject.methods - Object.instance_methods).should eq [:to_hash]
    end

    it 'responds to every property' do
      subject.should respond_to :property, :other
    end
  end

  context 'when a property is queried' do
    it 'returns the property value' do
      subject.property.should eq 'value'
      subject.other.should eq 'other'
    end

    it 'defines a new method to access the property' do
      subject.methods.should_not include(:property, :other)
      subject.property
      subject.methods.should include(:property)
      subject.other
      subject.methods.should include(:property, :other)
    end
  end

  it 'can be transformed to a hash' do
    subject.to_hash.should eq properties
  end
end

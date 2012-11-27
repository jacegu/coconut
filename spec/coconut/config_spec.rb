require 'coconut/config'

describe Coconut::Config do
  subject           { described_class.new(application) }
  let(:application) { Hash[twitter: properties] }
  let(:properties)  { Hash[property: 'value', other: 'other'] }

  context 'newly created' do
    it 'has no property methods' do
      (subject.methods - Object.instance_methods).should eq [:to_hash]
    end

    it 'responds to every property' do
      subject.should respond_to :twitter
    end
  end

  context 'when a property is queried' do
    it 'returns the property value' do
      subject.twitter.property.should eq 'value'
      subject.twitter.other.should eq 'other'
    end

    it 'defines a new method to access the property' do
      subject.methods.should_not include(:twitter)
      subject.twitter
      subject.methods.should include(:twitter)
    end
  end

  it 'can be transformed to a hash' do
    subject.to_hash.should eq application
  end
end

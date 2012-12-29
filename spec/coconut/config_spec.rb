require 'coconut/config'

describe Coconut::Config do
  subject          { described_class.with(assets) }
  let(:assets)     { Hash[twitter: properties] }
  let(:properties) { Hash[property: 'value', other: 'other'] }

  context 'newly created' do
    it 'has no property methods' do
      (subject.public_methods - Class.public_methods).should eq [:with, :to_hash]
    end

   it 'responds to every property' do
      subject.should respond_to :twitter
    end
  end

  context 'when a property is queried as a method' do
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

  context 'when a property is queried as a constant' do
    it 'returns the property value' do
      subject::TWITTER::PROPERTY.should eq 'value'
      subject::TWITTER::OTHER.should eq 'other'
    end

    it 'defines a new constant to access the property' do
      subject.constants.should_not include(:TWITTER)
      subject::TWITTER
      subject.constants.should include(:TWITTER)
    end
  end

 it 'can be transformed to a hash' do
    subject.to_hash.should eq assets
  end
end

require 'coconut/dsl/environment'

describe Coconut::Dsl::Environment do
  it 'creates an environment config' do
    config = described_class.configure do
      property 'value'
      other    'other'
    end
    config.fetch(:property).should eq 'value'
    config.fetch(:other).should eq 'other'
  end

  it "doesn't allow properties with colliding names" do
    expect {
      described_class.configure { send '11' }
    }.to raise_error Coconut::Dsl::InvalidName, /send/
  end

  it 'can take procs as property values' do
    config = described_class.configure do
      property1 Proc.new { 'value' }
      property2 Kernel::lambda { 'value' }
    end
    config.fetch(:property1).should be_a_kind_of Proc
    config.fetch(:property2).should be_a_kind_of Proc
  end

  it 'can take expressions as property values' do
    config = described_class.configure do
      property1 2 + 2
      property2 'aeiou'[0..2]
      property3 [:a, :e, :i, :o, :u].take(3)
    end
    config.fetch(:property1).should eq 4
    config.fetch(:property2).should eq 'aei'
    config.fetch(:property3).should eq [:a, :e, :i]
  end

  it 'can take constants and scoped method calls as property values' do
    config = described_class.configure do
      arguments Math::PI
      encodings Encoding.list
    end
    config.fetch(:arguments).should eq Math::PI
    config.fetch(:encodings).should eq Encoding.list
  end
end

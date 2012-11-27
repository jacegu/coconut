require 'coconut/dsl/environment'

describe Coconut::Dsl::Environment do
  it 'creates an environment config' do
    config = described_class.run do
      property 'value'
      other    'other'
    end
    config.property.should eq 'value'
    config.other.should eq 'other'
  end

  it "doesn't allow properties with colliding names" do
    expect {
      described_class.run { object_id '11' }
    }.to raise_error Coconut::InvalidName, /object_id/
  end
end

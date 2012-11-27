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
      described_class.configure { object_id '11' }
    }.to raise_error Coconut::Dsl::InvalidName, /object_id/
  end
end

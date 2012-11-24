require 'coconut/asset'

describe Coconut::Asset do
  it "knows the asset's config on the current environment" do
    subject = described_class.new(:current) do
      environment(:other)   { property 'value on other'   }
      environment(:current) { property 'value on current' }
    end
    subject.should have_key 'property'
    subject.fetch('property').should eq 'value on current'
  end
end

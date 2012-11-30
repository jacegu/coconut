require 'coconut/dsl/blank_slate'

describe Coconut::Dsl::BlankSlate do
  it 'knows the forbidden names' do
    expected_names =  described_class::PERMANENT_METHODS + [:one]
    Coconut::Config.stub(:instance_methods).and_return([:one])
    described_class.__forbidden_names.should include(*expected_names)
  end
end

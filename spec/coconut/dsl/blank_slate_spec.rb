require 'coconut/dsl/blank_slate'

describe Coconut::Dsl::BlankSlate do
  it 'knows the forbidden names' do
    expected_names =  described_class::PERMANENT_PUBLIC_METHODS + [:one]
    Coconut::Config.stub(:instance_methods).and_return([:one])
    described_class.__forbidden_names.should include(*expected_names)
  end

  it 'can look up for constants on the global namespace' do
    context = described_class.new
    expect { context.instance_eval('Kernel') }.not_to raise_error NameError
  end
end


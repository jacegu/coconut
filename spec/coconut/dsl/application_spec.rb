require 'coconut/dsl/application'

describe Coconut::Dsl::Application do
  it 'creates the config for every asset' do
    config = described_class.new(:current).run do
      asset { environment(:current) { property 'value' } }
    end
    config.asset.property.should eq 'value'
  end

  it "doesn't allow assets with colliding names" do
    expect {
      described_class.configure(:current) { to_s {} }
    }.to raise_error Coconut::Dsl::InvalidName, /to_s/
  end

  it 'can load the asset configuration from a folder' do
    path = '.'
    Coconut::Dsl::AssetFolder.stub(:config_from).with(path, ['config.rb']).
      and_return("asset { environment(:current) { property 'value' } }")
    config = described_class.configure(:current) { asset_folder path }
    config.asset.property.should eq 'value'
  end
end

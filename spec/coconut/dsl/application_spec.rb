require 'coconut/dsl/application'

describe Coconut::Dsl::Application do
  it 'creates the config for every asset' do
    config = described_class.new(:test).run do
      asset { environment(:test) { property 'value' } }
    end
    config.asset.property.should eq 'value'
  end

  it "doesn't allow assets with colliding names" do
    expect {
      described_class.configure(:test) { to_s {} }
    }.to raise_error Coconut::Dsl::InvalidName, /to_s/
  end

  it 'can load the asset configuration from a folder' do
    asset_path = '/file/path.rb'
    asset_config = "asset { environment(:test) { property 'value' } }"

    asset_folder = stub(:asset_folder)
    Coconut::Dsl::AssetFolder.stub(:new).and_return(asset_folder)
    asset_folder.stub(:each).and_yield(asset_config, asset_path)

    config = described_class.configure(:test) { asset_folder '.' }
    config.asset.property.should eq 'value'
  end

  it 'can load asset configuration from a list of asset files' do
    asset_path = '/file/path.rb'
    asset_config = "asset { environment(:test) { property 'value' } }"

    asset_file_list = stub(:asset_file_list)
    Coconut::Dsl::AssetFileList.stub(:new).and_return(asset_file_list)
    asset_file_list.stub(:each).and_yield(asset_config, asset_path)

    config = described_class.configure(:test) { asset_files asset_path }
    config.asset.property.should eq 'value'
  end
end

require 'coconut/config'

describe Coconut::Config do
  let(:asset_config) { Coconut::Asset }

  it 'configures a series of assets' do
    subject = described_class.new(:current) do
      ftp {}
      ssh {}
    end
    subject.should have_key 'ftp'
    subject.should have_key 'ssh'
  end

  it 'runs the configuration of each asset' do
    ftp_config = lambda {}
    ssh_config = lambda {}
    asset_config.should_receive(:new).with(:current, &ftp_config)
    asset_config.should_receive(:new).with(:current, &ssh_config)
    described_class.new(:current) do
      ftp &ftp_config
      ssh &ssh_config
    end
  end

  it 'assets can have (almost) any name' do
    subject = described_class.new(:current) do
      __id__  {}
      equal?  {}
      inspect {}
    end
    ['__id__', 'equal?', 'inspect'].each { |key| subject.should have_key(key) }
  end
end

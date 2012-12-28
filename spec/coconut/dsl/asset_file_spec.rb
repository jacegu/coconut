require 'coconut/dsl/asset_file'

describe Coconut::Dsl::AssetFile do
  subject      { described_class.new(path) }
  let(:path)   { '/tmp/asset.rb' }
  let(:config) { "asset { env(:current) { property 'value' } }" }

  before do
    File.open('/tmp/asset.rb', 'w+') { |f| f.write(config) }
  end

  after do
    File.delete('/tmp/asset.rb')
  end

  it 'has a path in the file system' do
    subject.path.should eq path
  end

  it 'reads the content of the file at path' do
    subject.asset_config.should eq config
  end
end

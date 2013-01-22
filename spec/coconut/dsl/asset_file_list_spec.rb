require 'coconut/dsl/asset_file_list'

describe Coconut::Dsl::AssetFileList do
  subject       { described_class.new(path1, path2) }
  let(:path1)   { '/tmp/asset1.rb' }
  let(:path2)   { '/tmp/asset2.rb' }
  let(:config1) { "asset1 { env(:current) { property 'value for asset1' } }" }
  let(:config2) { "asset2 { env(:current) { property 'value for asset2' } }" }

  before do
    File.open('/tmp/asset1.rb', 'w+') { |f| f.write(config1) }
    File.open('/tmp/asset2.rb', 'w+') { |f| f.write(config2) }
  end

  after do
    File.delete('/tmp/asset1.rb', '/tmp/asset2.rb')
  end

  it "yields each asset file's config and path in the list" do
    configs, paths = [], []
    subject.each { |config, path| paths << path and configs << config }
    paths.should include(path1, path2)
    configs.should include(config1, config2)
  end
end

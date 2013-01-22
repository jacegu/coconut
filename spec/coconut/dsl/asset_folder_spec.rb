require 'coconut/dsl/asset_folder'

describe 'Assets configuration from files in folder', integration: true do
  subject       { Coconut::Dsl::AssetFolder.new(path, ignored) }
  let(:path)    { '/tmp/coconut-testing/' }
  let(:ignored) { ['config.rb'] }

  let(:s3_config) { "s3       { environment(:current) { property 'p1' } }" }
  let(:db_config) { "database { environment(:current) { property 'p2' } }" }

  before do
    Dir::mkdir path
    File.open(File.join(path, 's3.rb'), 'w+') { |f| f.write s3_config }
    File.open(File.join(path, 'db.rb'), 'w+') { |f| f.write db_config }
  end

  after do
    `rm -rf #{path}`
  end

  shared_examples_for 'a folder with asset files only' do
    let(:paths)   { [] }
    let(:configs) { [] }

    it "yields every asset file's config and path" do
      subject.each { |config, path| paths << path and configs << config }
      paths.length.should be 2
      paths.should include('/tmp/coconut-testing/s3.rb', '/tmp/coconut-testing/db.rb')
      configs.length.should be 2
      configs.should include(s3_config, db_config)
    end
  end

  context 'with asset files only' do
    it_behaves_like 'a folder with asset files only'
  end

  context 'with asset files and a config.rb file' do
    before do
      File.open(File.join(path, 'config.rb'), 'w+') { |f| f.write '#config' }
    end

    it_behaves_like 'a folder with asset files only'
  end

  context 'with asset files and non Ruby files' do
    before do
      File.open(File.join(path, 'readme.md'), 'w+') { |f| f.write 'readme' }
    end

    it_behaves_like 'a folder with asset files only'
  end
end

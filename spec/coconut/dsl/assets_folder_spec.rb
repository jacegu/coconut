require 'coconut/dsl/asset_folder'

describe 'Assets configuration from files in folder', :integration do
  let(:path)    { '/tmp/coconut-testing/' }
  let(:ignored) { ['/tmp/coconut-testing/config.rb'] }

  let(:config)    { "" }
  let(:s3_config) { "s3       { environment(:current) { property 'p1' } }" }
  let(:db_config) { "database { environment(:current) { property 'p2' } }" }

  before :all do
    `rm -rf #{path}`
    Dir::mkdir path
    File.open(File.join(path, 'config.rb'), 'w+') { |f| f.write '' }
    File.open(File.join(path, 's3.rb'), 'w+')     { |f| f.write s3_config }
    File.open(File.join(path, 'db.rb'), 'w+')     { |f| f.write db_config }
  end

  it 'evals every asset file in the folder as application config' do
    Coconut::Dsl::AssetFolder.config_from(path, ignored).should eq "#{db_config}\n#{s3_config}"
  end
end

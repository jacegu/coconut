$: << File.join(File.dirname(__FILE__), '..', '..', 'lib')

require 'coconut'

CONFIG_FOLDER = '/tmp/coconut_config/'

Before do
  # create an empty namespace for each scenario
  MyApp = Module.new

  clean_tmp_folder
  `mkdir #{CONFIG_FOLDER}`
end

After do
  # remove created namespace to avoid warnings
  Object.send(:remove_const, :MyApp)

  clean_tmp_folder
end

def clean_tmp_folder
  `rm -rf #{CONFIG_FOLDER}` if File.directory?(CONFIG_FOLDER)
  `rm -f /tmp/coconut.rb` if File.exists?('/tmp/coconut.rb')
end

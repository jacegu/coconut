$: << File.join(File.dirname(__FILE__), '..', '..', 'lib')

require 'coconut'

CONFIG_FOLDER = '/tmp/coconut_config/'

Before do
  clean_tmp_folder
  create_folder_for_testing
  create_namespace_for_testing
end

After do
  clean_tmp_folder
  clean_namespace_for_testing
end

def create_namespace_for_testing
  Object.send(:const_set, :MyApp, Module.new) 
end

def clean_namespace_for_testing
  Object.send(:remove_const, :MyApp)
end

def clean_tmp_folder
  `rm -rf #{CONFIG_FOLDER}` if File.directory?(CONFIG_FOLDER)
  `rm -f /tmp/coconut.rb` if File.exists?('/tmp/coconut.rb')
end

def create_folder_for_testing
  `mkdir #{CONFIG_FOLDER}`
end

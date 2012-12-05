Given /^I have my application config in "(.*?)" with content:$/ do |file, content|
  @config = file
  File.open(file, 'w+') { |file| file.write(content) }
end

Given /^I have a "(.*?)" asset file on (.*?) with content:$/ do |name, folder, content|
  File.open(File.join(folder, name), 'w+') { |file| file.write(content) }
end

When /^I run my application on the "(.*?)" environment$/ do |environment|
  ENV['RACK_ENV']= environment
  eval "load '#{@config}'"
end

When /^I query the configuration for "(.*?)"$/ do |query|
  @query = "MyApp.config.#{query}"
end

Then /^the configured value should be "(.*?)"$/ do |expected_result|
  eval(@query).should eq expected_result
end

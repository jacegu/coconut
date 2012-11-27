Given /^my application is configured like this:$/ do |configuration|
  @app_config = configuration
end

When /^I run my application on the "(.*?)" environment$/ do |environment|
  ENV['RACK_ENV']= environment
  eval @app_config
end

When /^I query the configuration for "(.*?)"$/ do |query|
  @query = "MyApp.config.#{query}"
end

Then /^the configured value should be "(.*?)"$/ do |expected_result|
  eval(@query).should eq expected_result
end

After do
  MyApp.singleton_class.instance_eval { undef_method :config }
end

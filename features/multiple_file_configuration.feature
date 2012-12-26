Feature: Load configuration from specific asset files.

  You can split your configuration into asset files, and tell Coconut to load
  the configuration from them.

  Scenario: Loading asset configuration from specific files.
    Given I have my application config in "/tmp/coconut_config/config.rb" with content:
      """
      Coconut.configure MyApp do
        asset_files '/tmp/coconut_config/s3.rb'
      end
      """
      And I have a "s3.rb" asset file on /tmp/coconut_config with content:
      """
      s3 do
        env(:development) { key 'xxx' }
        env(:production)  { key 'yyy' }
      end
      """
     When I run my application on the "production" environment
      And I query the configuration for "s3.key"
     Then the configured value should be "yyy"

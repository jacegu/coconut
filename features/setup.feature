Feature: Setting up an asset in the configuration

  Many times you use your configuration values to setup a gem or external
  library. Coconut will allow you to put this code where it belongs: your
  configuration files.

  Scenario: Setting up an asset
    Given I have my application config in "/tmp/coconut_config/config.rb" with content:
      """
      Coconut.configure(MyApp) do
        ftp do
          environment(:development) do
            user 'root'
            pass '1234'
          end
          setup do
            DummyFtp.user = user
            DummyFtp.pass = pass
          end
        end
      end
      """
    When I run my application on the "development" environment
    Then my setup block should have been called with the correct values


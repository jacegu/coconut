Feature: Single file configuration

  Scenario: One environment configuration
    Given my application is configured like this:
      """
      Coconut.configure(MyApp) do
        ftp do
          environment(:development) do
            user 'root'
          end
        end
      end
      """
    When I run my application on the "development" environment
     And I query the configuration for "ftp.user"
    Then the configured value should be "root"

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

  Scenario: Several environments configuration
    Given my application is configured like this:
      """
      Coconut.configure(MyApp) do
        ftp do
          environment(:development, :staging, :production) do
            user 'root'
          end
        end
      end
      """
    When I run my application on the "development" environment
     And I query the configuration for "ftp.user"
    Then the configured value should be "root"



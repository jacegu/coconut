Feature: Single file configuration

  Scenario: One environment configuration
    Given I have my application config in "/tmp/coconut_config/config.rb" with content:
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
    Given I have my application config in "/tmp/coconut_config/config.rb" with content:
      """
      Coconut.configure(MyApp) do
        ssh do
          environment(:development, :staging, :production) do
            login 'username'
          end
        end
      end
      """
    When I run my application on the "development" environment
     And I query the configuration for "ssh.login"
    Then the configured value should be "username"

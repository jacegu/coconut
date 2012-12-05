Feature: Load configuration from folder

  You can split your configuration into asset files, put those files into a
  folder and tell Coconut to load the configuration from there. That
  folder should only include asset files. If it includes some other Ruby file
  Coconut will try to execute it as such and you will get an error.

  In order to be able to have all the configuration related files in a single
  folder you can adhere to the convention and put your application configuration
  in a file called 'config.rb' inside that folder.

  If Coconut will ignore that file and it won't be executed as if it was an
  asset file.

  You can also have your application related configuration in other folder and
  use the file name that you want.

  Scenario: Application file and assets file under the same folder
    Given I have my application config in "/tmp/coconut_config/config.rb" with content:
      """
      Coconut.configure MyApp do
        asset_folder '/tmp/coconut_config'
      end
      """
      And I have a "s3.rb" asset file on /tmp/coconut_config with content:
      """
      s3 do
        env(:development) { key 'xxx' }
        env(:production)  { key 'yyy' }
      end
      """
     When I run my application on the "development" environment
      And I query the configuration for "s3.key"
     Then the configured value should be "xxx"


  Scenario: Application file and assets file in different folders
    Given I have my application config in "/tmp/coconut.rb" with content:
      """
      Coconut.configure MyApp do
        asset_folder '/tmp/coconut_config'
      end
      """
      And I have a "s3.rb" asset file on /tmp/coconut_config with content:
      """
      facebook do
        env(:development) { key 'xxx' }
        env(:production)  { key 'yyy' }
      end
      """
     When I run my application on the "development" environment
      And I query the configuration for "facebook.key"
     Then the configured value should be "xxx"

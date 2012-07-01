Feature: Command Line Interface with helpful comments

  As a user
  I want to normalise data from the command line
  So that I can normalise data quickly or in scripts

  Scenario: User asks for help and gets it!
    When I run `csv_normalise -h` 
    Then the output should contain "Usage:"
    And the exit status should be 0

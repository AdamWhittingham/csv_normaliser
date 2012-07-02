Feature: Command Line Interface is available and documented

  As a user
  I want to normalise data from the command line
  So that I can normalise data quickly or from within scripts

  Scenario Outline: User asks for help and gets it
    When I run `csv_normalise <help_switch>`
    Then the output should contain "Usage:"
    And the exit status should be 0

    Examples:
      | help_switch |
      | -h          |
      | --help      |
      | -?          |

    #@announce
  #Scenario: Date format can be specified on the command line
    #Given an example containing dates
    #When I run `csv_normalise -d "%Y-%m-%d %H.%M.%S" ../tmp/test.csv`
    #Then the dates should be in the format '%Y-%m-%d %H.%M.%S'

  Scenario: Realative normalisation is the default
    Given an example csv
    When I set no options
    And I call from the command line with the test file
    Then the output should be normalised relative to the largest value

  Scenario: Percentage normalisation can be used
    Given an example csv
    When I set the '-p' option
    And I call from the command line with the test file
    Then the output should be normalised into percentages

  Scenario: Percentage normalisation can be used with the full switch
    Given an example csv
    When I set the '--percentage' option
    And I call from the command line with the test file
    Then the output should be normalised into percentages

  Scenario: Degree normalisation can be used
    Given an example csv
    When I set the '-e' option
    And I call from the command line with the test file
    Then the output should be normalised into degrees

  Scenario: Degree normalisation can be used with the full switch
    Given an example csv
    When I set the '--degrees' option
    And I call from the command line with the test file
    Then the output should be normalised into degrees

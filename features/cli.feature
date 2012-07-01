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

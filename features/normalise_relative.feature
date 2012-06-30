Feature: CSV's are normalised relative to the largest value in a column

  Scenario: A CSV file can be normalised by column
    Given an example containing integers and floats
    When I call normalise_csv from the command line with a file argument
    Then the output should be normalised relative to the largest value

  Scenario: A CSV string can be normalised by column
    Given an example containing integers and floats
    When I call normalise_csv from ruby with a file argument
    Then the output should be normalised relative to the largest value

  Scenario: A CSV on stdin can be normalised by column
    Given an example containing integers and floats
    When I call normalise_csv from the command line with data on stdin
    Then the output should be normalised relative to the largest value


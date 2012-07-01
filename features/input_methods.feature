Feature: The library can be used through multiple interfaces

  As a user
  I want to be able to normalise my data through multiple input methods
  So that I can use the library in other apps, scripts or from the command line

  Scenario: File input can be normalised by column
    Given an example containing integers and floats
    When I call from the command line with a test file
    Then the output should be normalised relative to the largest value

  Scenario: String input can be normalised by column
    Given an example containing integers and floats
    When I call from ruby with a test file
    Then the output should be normalised relative to the largest value

  Scenario: STDIN input can be normalised by column
    Given an example containing integers and floats
    When I call from the command line with data on stdin
    Then the output should be normalised relative to the largest value


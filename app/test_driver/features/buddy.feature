Feature: Intractable Buddy
  Scenario: The user has a pet buddy that they can interact with
    Given I have "loginButton" and "registerButton"
    Then I tap the "loginButton" button
    Then I wait until the "loginScreen" is present

    Given I have "loginButton" and "emailField" and "passwordField"
    When I press the "emailField" and type "test1@gmail.com"
    Then I press the "passwordField" and type "password"
    Then I tap the "loginButton" button


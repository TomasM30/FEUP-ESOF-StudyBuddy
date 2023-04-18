  Feature: Login screen
  Scenario: A user has an account and wishes to log in
    Given I have "loginButton" and "registerButton"
    Then I tap the "loginButton" button
    Then I wait until the "loginScreen" is present

    Given I have "loginButton" and "emailField" and "passwordField"
    When I press the "emailField" and type "test@gmail.com"
    Then I press the "passwordField" and type "password"
    Then I tap the "loginButton" button
    Then I wait until the "buddyScreen" is present

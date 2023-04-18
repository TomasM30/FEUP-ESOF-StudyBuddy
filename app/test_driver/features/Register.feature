Feature: Registration Screen
  Scenario: The user just installed the app and wants to create an account
    Given I have "loginButton" and "registerButton"
    Then I tap the "registerButton" button
    Then I wait until the "signupScreen" is present

    Given I have "signupButton" and "emailField" and "passwordField"
    When I press the "emailField" and type "test@gmail.com"
    Then I press the "passwordField" and type "password"
    Then I tap the "signupButton" button
    Then I wait until the "loginScreen" is present

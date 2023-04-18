Feature: Timer Display
  Scenario: The user wishes to study and to time how long they are studying for
    Given I have "loginButton" and "registerButton"
    Then I tap the "loginButton" button
    Then I wait until the "loginScreen" is present

    Given I have "loginButton" and "emailField" and "passwordField"
    When I press the "emailField" and type "test@gmail.com"
    Then I press the "passwordField" and type "password"
    Then I tap the "loginButton" button
    Then I wait until the "buddyScreen" is present

    Given I have "toggleButton" and "buddyScreen"
    Then I tap the "toggleButton" button

    Given I have "studyModeButton" and "buddyScreen"
    Then I tap the "studyModeButton" button
    Then I wait until the "studyModeScreen" is present

    Given I have "timerText" and "studyModeScreen"
    Then I have "timerText"

Feature: Toggle Music and Notifications
  Scenario: A user is in the study mode wanting to not be distracted by notifications or other phone noises and wants to be able to listen to music
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

    Given I have "toggleButtonH" and "studyModeScreen"
    Then I tap the "toggleButtonH" button

    Given I have "dndButton" and "musicButton" and "studyModeScreen"
    Then I tap the "dndButton" button
    Then I tap the "musicButton" button

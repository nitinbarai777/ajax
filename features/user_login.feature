Feature: Login
  In order to use the service
  As an user
  I want to login into the service
  
  Scenario: Login
    Given I am on the login page
    And default user exists
    When I fill in "email" with "user@dee.de"
    And I fill in "password" with "foobar"
    And I press "login"
    Then I should see "Logout"

  Scenario: Logout
    Given I'm logged in as default user
    When I follow "Logout"
    Then I should see "Login"

# 10. Marketing Preferences Tests
@my-account
@10_arketing_prefs
Feature: This feature file tests the Marketing Preferences functionality for my-account

  Background:
    Given I visit the Login page
  @10_1
  Scenario: 10_1 : Checking the Marketing Preferences functionality for my account
    Then The correct content for the login page should be displayed
    And I fill in the username and password and click login
    Then I should see the my account page
    Then I click on Personal Details tab
    Then I check contact preferences content is correct
    And I modify the preferences from myaccount
    Then I login to SF as Admin User
    And I check that the preferences were modified in SF
    Then I modify the preferences from SF
    And I visit the homepage
    Then I should see the my account page
    Then I click on Personal Details tab
    And I check that the preferences were modified in myaccount
    Then I reset the preferences
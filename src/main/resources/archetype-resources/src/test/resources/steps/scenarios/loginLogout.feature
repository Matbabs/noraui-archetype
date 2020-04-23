﻿@loginLogout
Feature: loginLogout (Scenario that 1st sample. Is it a login and logout on a JHipster sample.) 

  Scenario Outline:  Scenario that 1st sample. Is it a login and logout on a JHipster sample.

    Given I check that 'user' '<user>' is not empty
    Given I check that 'password' '<password>' is not empty

    Given '${targetApplicationId.toUpperCase()}_HOME' is opened
    Then The ${targetApplicationId.toUpperCase()} home page is displayed

    When I log in to ${targetApplicationId.toUpperCase()} as '<user>' '<password>'
    Then The ${targetApplicationId.toUpperCase()} portal is displayed with the login '<user>'

    When I log out of ${targetApplicationId.toUpperCase()}
    Then The ${targetApplicationId.toUpperCase()} logout page is displayed

    And I go back to '${targetApplicationId.toUpperCase()}_HOME'
  Examples:
    #DATA
    |id|user|password|
    #END

﻿@search
Feature: search (Scenario that 1st sample. Is it a search on Google search motor.)

  Scenario Outline:  Scenario that 1st sample. Is it a search on Google search motor.

    Given I check that 'search' '<search>' is not empty

    Given 'GOOGLE_HOME' is opened
    Then The GOOGLE home page is displayed

    And I update text $google.GooglePage-searchField and type ENTER with '<search>'

    And I wait 5 seconds

    And I go back to 'GOOGLE_HOME'

  Examples:
    #DATA
    |id|search|
    #END
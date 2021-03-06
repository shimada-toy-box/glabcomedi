Feature: Project Network Graph
  Background:
    Given I sign in as a user
    And I own project "Shop"
    And I visit project "Shop" network page

  @javascript
  Scenario: I should see project network
    Then page should have network graph
    And page should select "master" in select box
    And page should have "master" on graph

  @javascript
  Scenario: I should see project network with 'test' branch
    When I visit project network page on branch 'test'
    Then page should have 'test' on graph

  @javascript
  Scenario: I should switch "branch" and "tag"
    When I switch ref to "feature"
    Then page should select "feature" in select box
    And page should have "feature" on graph
    When I switch ref to "v1.0.0"
    Then page should select "v1.0.0" in select box
    And page should have "v1.0.0" on graph

  @javascript
  Scenario: I should looking for a commit by SHA
    When I looking for a commit by SHA of "v1.0.0"
    Then page should have network graph
    And page should select "master" in select box
    And page should have "v1.0.0" on graph

  @javascript
  Scenario: I should filter selected tag
    When I switch ref to "v1.0.0"
    Then page should have "v1.0.0" in title
    Then page should have content not containing "v1.0.0"
    When click "Show only selected branch" checkbox
    Then page should only have content from "v1.0.0"
    When click "Show only selected branch" checkbox
    Then page should have content not containing "v1.0.0"

  Scenario: I should fail to look for a commit
    When I look for a commit by ";"
    Then I should see non-existent git revision error message

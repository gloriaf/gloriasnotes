Feature: User manges topics
    In order to manage topics
    As an user
    I want add, update, delete, show and see a list of topics
    
    Background: topics and notes in database
	Given the following topics exists:
	| name     | topic_type | description |
	| Cucumber | Tool       | BDD         |
	| Rspec    | Tool       | TDD         |
        And the following notes exists for "Cucumber"
	
    Scenario: User add a new topic	    
        Given I go to the new topic page
#	Then show me the page
	And I fill in "Name" with "git"
	And I fill in "Topic type" with "Tool"
	And I fill in "Description" with "Version control"
	When I press "Create"
	Then I should be on the topic list page
	And I should see "Git"

    Scenario: User not add a new topic	    
        Given I go to the new topic page
	And I fill in "Name" with "Test"
	And I fill in "Topic type" with "blank"
	When I press "Create"
	Then I should be on the new page
	And I should not see "Test"
	And I should see an error message
    
    Scenario: Show topic
	Given I am on the topic list page
	When I go to the show page for "Cucumber"
	Then I should see "Cucumber"
#	Then show me the page
	And I should see "Tool"
	And I should see the 2 notes 
    
    Scenario: Edit topic
	Given I am on the topic list page
	When I go to the edit page for "Cucumber"
	Then I should see "Edit Topic"
	When I press "Update topic"
	Then I should be on the show page for "Cucumber"

    Scenario: Not update topic
	Given I am on the topic list page
	When I go to the edit page for "Cucumber"
	Then I should see "Edit Topic"
	And I fill in "Name" with ""
	When I press "Update topic"
	Then I should see an error message

    Scenario: Add a new note about topic 
	Given I am on the show page for "Cucumber"
#	Then show me the page
	Then I should see "New Note"
	When I go to the new note page for "Cucumber"
#	Then show me the page
	Then I should see "Cucumber"
	And I should see "Text"

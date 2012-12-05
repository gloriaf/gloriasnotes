Feature: User manges topics
    In order to manage topics
    As an user
    I want add, update, delete, show and see a list of topics
    
    Background: topics in database
	Given the following topics exists:
	| name     | topic_type | description |
	| Cucumber | Tool       | BDD         |
	| Rspec    | Tool       | TDD         |
	
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
	And I should see "BDD"
    
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

    Scenario: User see notes from topics list
	Given I am on the topic list page
	When I go to the notes page for "Cucumber"
	Then I should be on the notes list page
	And I should see Notes about "Cucumber"

Feature: User manges topics
    In order to manage notes about a topic
    As an user
    I want add, update, delete, show notes about a topic
    
    Background: topics and notes in database
	Given the following topics exists:
	| name     | topic_type | description |
	| Cucumber | Tool       | BDD         |
	| Rspec    | Tool       | TDD         |
        And the following notes exists for "Cucumber"
	
    Scenario: User add a new note	    
        Given I am on the new note page for "Cucumber"
	And I fill in "Sequence" with "10"
	And I fill in "Text" with "Note for topic"
	When I press "Create"
	Then I should be on the show page for "Cucumber"
#	Then show me the page
	And I should see "Note for topic"

    Scenario: User not add a new topic	    
        Given I an on the new note page for "Cucumber"
	And I fill in "Sequence" with "0"
	And I fill in "Text" with ""
	When I press "Create"
	And I should see an error message

    Scenario: New note about a topic and back
	Given I am on the new note page for "Cucumber"
	When I follow "Back"
	Then I should be on the show page for "Cucumber"
    
    Scenario: Show note about a topic
	Given I am on the show page for "Cucumber"
	When I go to the show note page for note "100" and "Cucumber"
	Then I should see "Show Note"
	And I should see "100" 
    
    Scenario: Show note about a topic and back
	Given I am on the show page for "Cucumber"
	When I go to the show note page for note "100" and "Cucumber"
	Then I should see "Show Note"
	When I follow "Back"
	Then I should be on the show page for "Cucumber"
    
    Scenario: Show note about a topic and edit
	Given I am on the show page for "Cucumber"
	When I go to the show note page for note "100" and "Cucumber"
	Then I should see "Show Note"
	When I follow "Edit"
	Then I should be on the edit note page for note "100" and "Cucumber"
    
    Scenario: Edit and update note 
	Given I am on the show page for "Cucumber"
	When I go to the edit note page for note "100" and "Cucumber"
	Then I should see "Edit Note"
	When I press "Update note"
	Then I should be on the show note page for note "100" and "Cucumber"

    Scenario: Edit and not update note 
	Given I am on the show page for "Cucumber"
	When I go to the edit note page for note "100" and "Cucumber"
	Then I should see "Edit Note"
	When I fill in "Sequence" with "0"
	And I press "Update note"
#	Then show me the page
	And I should see an error message

    Scenario: Edit and back to show page 
	Given I am on the show page for "Cucumber"
	When I go to the edit note page for note "100" and "Cucumber"
	Then I should see "Edit Note"
	When I follow "Back"
	Then I should be on the show page for "Cucumber"


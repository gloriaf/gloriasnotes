Feature: display list of movies sorted by different criteria
 
  As an user
  So that I can quickly find a topic
  I want to filter topics sorted by topic type

 Background: topics in database
   Given the following topics exists:
   | name     | topic_type | description             |
   | Rspec    | Tool       | TDD                     |
   | Cucumber | Tool       | BDD                     |
   | RoR      | Framework  | Add Versions control    |
   | Ruby     | Language   | Programing languge      |
   | Saas     | Other      | Software as a Service   |
   And I am on the topic list page

 Scenario: restrict to topics whit 'Tool' or 'Language' topic types
   When I check "topics_types[Tool]"
   And I check "topics_types[Language]"
   And I uncheck "topics_types[Framework]"
   And I uncheck "topics_types[Other]"
   And I press "Refresh"
   Then I should be on the topic list page
   And I should see "Cucumber"
   And I should see "Ruby"
   And I should not see "Ror"
   And I should not see "Saas"
   
 Scenario: no topics type selected
   When I uncheck the following topics_types: Tool,Framework,Language,Other
   And I press "Refresh"
   Then I should be on the topic list page
   Then I should see all the topics

 Scenario: all topics type selected
   When I check the following topics_types: Tool,Framework,Language,Other
   And I press "Refresh"
   Then I should be on the topic list page
   Then I should see all the topics


Feature: display list of movies sorted by different criteria
 
  As an user
  So that I can quickly find a topic
  I want to see topics sorted by name or topic type

 Background: topics in database
   Given the following topics exists:
   | name     | topic_type | description             |
   | Rspec    | Tool       | TDD                     |
   | Cucumber | Tool       | BDD                     |
   | Git      | Tool       | Add Versions control    |

 Scenario: sort topics alphabetically by name
   Given I am on the topic list page
   And I should see "Cucumber" before "Rspec" 
   When I follow "Name"
   Then I should see "Rspec" before "Cucumber" 




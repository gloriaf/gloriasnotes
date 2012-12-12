FactoryGirl.define do
# Crea topicos genericos
  factory :topic do
    sequence(:name) { |n| "Topic #{n}" }
    topic_type    "Tool"
    description   "description"
    documentation "documentation"
  end
  

  factory :note do 
    sequence(:sequence) {|n| n * 10 }   
    text   "description"
    topic
  end

end
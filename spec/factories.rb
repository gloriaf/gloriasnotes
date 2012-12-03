FactoryGirl.define do
# Crea topicos genericos
  factory :topic do |f|
    f.name  { "Topic #{f}" }
    f.topic_type    "Tool"
    f.description   "description"
    f.documentation "documentation"
  end

end
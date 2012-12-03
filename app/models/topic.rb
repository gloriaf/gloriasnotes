class Topic < ActiveRecord::Base
  attr_accessible :description, :documentation, :name, :topic_type
  
  before_save { |topic| topic.name = name.downcase.capitalize }
  
  validates(:name, presence: true, length: { maximum: 100}, :uniqueness => { case_sensitive: false})
  validates(:topic_type, presence: true, :inclusion => { in: %w(Tool Framework Language Other)})
  validates(:description, length: { maximum: 240})

  def self.all_topic_types
    %w(Tool Framework Language Other)
  end
  
end

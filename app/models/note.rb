class Note < ActiveRecord::Base
  attr_accessible :english, :spanish, :sequence, :text
  belongs_to :topic
  
  default_scope order: 'sequence, created_at DESC'
  
  validates :topic_id, presence: true
  validates :sequence, presence: true, :uniqueness => { :scope => :topic_id, :message => "Sequence must be unique to the topic" }, numericality: { greater_than: 0 }
  validates :text,     presence: true
  
end

class Note < ActiveRecord::Base
  attr_accessible :link1, :link2, :sequence, :text
  belongs_to :topic
  
  validates :topic_id, presence: true
  validates :sequence, presence: true, uniqueness: true, numericality: { greater_than: 0 }
  validates :text,     presence: true
  
end

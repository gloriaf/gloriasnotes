class Topic < ActiveRecord::Base
  attr_accessible :description, :documentation, :name, :topic_type
end

class FixColumnName < ActiveRecord::Migration
  def self.up
    rename_column :topics, :type, :topic_type
  end

end

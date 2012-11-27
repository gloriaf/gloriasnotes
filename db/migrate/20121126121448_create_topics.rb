class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :name
      t.string :type
      t.string :description
      t.string :documentation

      t.timestamps
    end
  end
end

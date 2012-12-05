class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.integer :sequence
      t.string :text
      t.string :link1
      t.string :link2
      t.integer :topic_id

      t.timestamps
    end
    add_index :notes, [:topic_id, :sequence]
  end
end

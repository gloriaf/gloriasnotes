class RenameColumnsName < ActiveRecord::Migration
  def change
    change_table :notes do |t|
      t.rename :link1, :english
      t.rename :link2, :spanish
    end
  end
  
end

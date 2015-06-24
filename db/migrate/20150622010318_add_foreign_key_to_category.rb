class AddForeignKeyToCategory < ActiveRecord::Migration
  def change
  	add_column :categories, :creator_id, :integer
  end

end

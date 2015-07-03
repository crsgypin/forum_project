class CreateFriendRelationTags < ActiveRecord::Migration
  def change
    create_table :friend_relation_tags do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end

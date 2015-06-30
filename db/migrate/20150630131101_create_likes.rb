class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.references :user
      t.references :article

      t.timestamps null: false
    end

    add_column :articles, :likes_count, :integer
    add_index :likes, :user_id
    add_index :likes, :article_id

  end
end

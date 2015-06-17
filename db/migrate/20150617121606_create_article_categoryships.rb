class CreateArticleCategoryships < ActiveRecord::Migration
  def change
    create_table :article_categoryships do |t|
    	t.integer :category_id
    	t.integer :article_id
      t.timestamps null: false
    end
  end
end

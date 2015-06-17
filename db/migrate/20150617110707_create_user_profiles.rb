class CreateUserProfiles < ActiveRecord::Migration
  def change
    create_table :user_profiles do |t|

    	t.string :first_name
    	t.string :last_name
    	t.string :english_name
    	t.date :birthdate
    	t.text :intro
      
    	t.integer :user_id

      t.timestamps null: false
    end
  end
end

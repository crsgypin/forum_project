class AddImageToUserProfile < ActiveRecord::Migration
  def change
  	add_attachment :user_profiles, :image
  end
end

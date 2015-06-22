class Category < ActiveRecord::Base

	has_many :article_categoryships
	has_many :articles, :through => :article_categoryships
	belongs_to :user, :foreign_key => :creator_id

	validates_presence_of :name	
end

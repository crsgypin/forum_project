class Article < ActiveRecord::Base
	has_many :comments
	belongs_to :user, :foreign_key => :author_id
	has_many :article_categoryships
	has_many :categories, :through => :article_categoryships
	has_many :article_views
end

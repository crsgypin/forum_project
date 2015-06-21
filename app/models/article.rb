class Article < ActiveRecord::Base
	has_many :comments
	belongs_to :user, :foreign_key => :author_id
	has_many :article_categoryships
	has_many :categories, :through => :article_categoryships
	has_many :article_views
	has_many :favorites
	has_many :user_favorites, :through=>:favorites, :source=>:user

	validates_presence_of :author_id
	validates_presence_of :title
	validates_presence_of :content
end

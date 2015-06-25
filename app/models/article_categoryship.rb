class ArticleCategoryship < ActiveRecord::Base
	belongs_to :article
	belongs_to :category

	validates_presence_of :category_id
	validates_presence_of :article_id
 
end

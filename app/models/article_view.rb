class ArticleView < ActiveRecord::Base

	belongs_to :article, :counter_cache => "views_count"
	belongs_to :user

end

class Like < ActiveRecord::Base
	belongs_to :user
	belongs_to :article, :counter_cache => "likes_count"

	def self.find_by_user_article(user,article)
		like = user.likes.find_by(:article_id=>article.id)
		like = user.likes.new unless like
		like
		# @like = current_user.likes.find_or_create_by(:article_id=>@article.id)

	end


end

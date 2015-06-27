class Comment < ActiveRecord::Base
	belongs_to :article
	belongs_to :user
	
	validates_presence_of :content	

	def self.all_order_by_updated_at(article)
		article.comments.order(:updated_at => :desc)
	end


end

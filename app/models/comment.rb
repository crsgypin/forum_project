class Comment < ActiveRecord::Base
	
	belongs_to :article, :counter_cache => true
	belongs_to :user
	
	validates_presence_of :content	


end

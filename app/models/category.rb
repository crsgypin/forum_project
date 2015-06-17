class Category < ActiveRecord::Base

	has_many :article_categoryships
	has_many :articles, :through => :article_categoryships

end

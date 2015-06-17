class Article < ActiveRecord::Base
	has_many :comments
	has_many :article_categoryships
	has_many :categories, :through => :article_categoryships

end

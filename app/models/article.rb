class Article < ActiveRecord::Base
	has_many :comments
	belongs_to :user, :foreign_key => :author_id
	has_many :article_categoryships
	has_many :categories, :through => :article_categoryships
	has_many :article_views
	has_many :favorites
	has_many :user_favorites, :through=>:favorites, :source=>:user

	validates :author_id, presence: true
	validates :title, presence: true, :unless => :status_draft?
	validates_presence_of :content, unless: :status_draft?

	def status_draft?
		puts status == "draft"
		status == "draft"
	end

end

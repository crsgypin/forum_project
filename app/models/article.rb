class Article < ActiveRecord::Base
	
	has_many :comments, -> { order("id DESC") }

	belongs_to :user, :foreign_key => :author_id
	has_many :article_categoryships
	has_many :categories, :through => :article_categoryships
	has_many :article_views
	has_many :favorites
	has_many :user_favorites, :through=>:favorites, :source=>:user
	has_many :likes
	has_many :user_likes, :through=>:likes, :source=>:user

	validates :author_id, presence: true
	validates :title, presence: true, :unless => :status_draft?

	validate :check_categories

	validates_presence_of :content, unless: :status_draft?

	def category_names
		self.categories.map{ |x| x.name}.join(" ")
	end

	def published?
		status == "published"
	end

	def status_draft?
		status == "draft"
	end

	def view!(user)
		self.article_views.find_or_create_by( :user_id => user.id )
	end

	protected

	def check_categories
		if self.categories.empty?
			errors[:base] = "Must select one category!"
		end
	end

end

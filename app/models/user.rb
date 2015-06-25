class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  before_create :create_profile, :set_role

  has_one :user_profile
  has_many :post_articles, :class_name=> "Article", :foreign_key => "author_id"
  has_many :comments
  has_many :reply_articles, :through  => :comments, :source=>:article
  has_many :article_views
  has_many :favorites
  has_many :favorite_articles, :through =>:favorites, :source=>:article
  has_many :create_categories, :class_name => "Category", :foreign_key => :creator_id
  accepts_nested_attributes_for :user_profile, :allow_destroy => true, :reject_if => :all_blank


  def admin?
    self.role == "admin"
  end

  def create_profile
    build_user_profile(:first_name=>"pop nn")
  end

  def set_role
    self.role = "user"
  end

end

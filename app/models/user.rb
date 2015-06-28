class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook]

  before_create :set_role

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

  def set_role
    self.role = "user"
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
    user.email = auth.info.email
    user.password = Devise.friendly_token[0,20]
    user.username = auth.info.name   # assuming the user model has a name
    # user.image = auth.info.image # assuming the user model has an image
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

end



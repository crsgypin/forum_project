class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]

  before_create :set_role

  has_one :user_profile, :dependent => :destroy
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
    user = User.find_by(:provider=>auth.provider,:uid=>auth.uid)
    if user
      return user
    end

    new_user = User.find_by_email(auth.info.email)
    unless new_user
      new_user = User.new
      new_user.email = auth.info.email
      new_user.password = Devise.friendly_token[0,20] 
      new_user.username = auth.info.name

    end
    new_user.build_user_profile unless new_user.user_profile
    new_user.provider = auth.provider
    new_user.uid = auth.uid
    new_user.token = auth.credentials.token
    new_user.user_profile.image = auth.info.image.sub('http','https')
    new_user.user_profile.first_name = auth.info.first_name
    new_user.user_profile.last_name = auth.info.last_name
    new_user.save
    new_user
    # user.image = auth.info.image # assuming the user model has an image
  end

# Don't understand this method
  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

end



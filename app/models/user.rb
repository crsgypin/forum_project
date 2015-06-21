class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_one :user_profile
  has_many :post_articles, :class_name=> "Article", :foreign_key => "author_id"
  has_many :comments
  has_many :reply_articles, :through  => :comments, :source=>:article
  has_many :article_views
  has_many :favorites
  has_many :favorite_articles, :through =>:favorites, :source=>:article

end

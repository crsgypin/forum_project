class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_one :user_profile
  has_many :post_articles, :class=> "Article", :foreign_key => "Author_id"
  has_many :comments
  has_many :reply_articles, :class => "Article", :through  => :comments

end

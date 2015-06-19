namespace :dev do 
	task :fake => :environment do 

		User.destroy_all
		Article.destroy_all
		ArticleCategoryship.destroy_all
		ArticleView.destroy_all
		Comment.destroy_all



		total_users = 200

		total_post_users = 40
		total_articles = 300

		total_comment_users = 100
		total_comments = 1000

		total_view_users = 200
		total_views = 3000		


		puts "creating users"
		User.create(:id=>1,
								:email=>'liwen@gmail.com',
								:username=>'liwen',
								:password =>'qwerty1234', 
								:password_confirmation=>'qwerty1234',
								:confirmed_at=>Time.now,
								:role=>"admin")

		(total_users-1).times do |i|
			User.create(:id=>i+2,
									:email=>Faker::Internet.free_email,
									:username=>Faker::Name.name,
									:password=>"qwerty1234",
									:password_confirmation=>"qwerty1234",
									:confirmed_at=>Time.now,
									:role=>"user")
		end

		puts "posting the articles"
		total_articles.times do |index|

			# assume the first 20 users would post the articles
			post_user_id = Random.rand(20)+1	

			article_id = index+1

			# user post the article
			article = Article.create(:id=>article_id,
															 :title=>Faker::Name.title,
															 :content=>Faker::Lorem.paragraph,
															 :author_id=>post_user_id)

			#article associates the category
			associate = (Random.rand(5)>0)? 1 : 2			
			associate.times do
				category_id = Random.rand(6)+1
				ArticleCategoryship.create(:article_id=>article_id,
																	 :category_id=>category_id) 
			end				

		end 

		puts "viewing the articles"
		total_views.times do |v|
			view_user_id = Random.rand(total_view_users)+1
			article_id = Random.rand(total_articles)+1
			ArticleView.create(:id=>v+1,
													:user_id=>view_user_id,
													:article_id=>article_id)
		end

		puts "commenting the articles"
		total_comments.times do |k|
			reply_user_id = Random.rand(total_comment_users)+1
			article_id = Random.rand(total_articles)+1
			Comment.create(:id => k+1,
										 :content=>Faker::Lorem.sentence, 
										 :user_id=>reply_user_id, 
										 :article_id => article_id)
		end


	end
end 


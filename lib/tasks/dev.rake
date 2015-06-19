namespace :dev do 
	task :fake => :environment do 

		User.destroy_all
		UserProfile.destroy_all
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
		u = User.create(:id=>1,
										:email=>'liwen@gmail.com',
										:username=>'liwen',
										:password =>'qwerty1234', 
										:password_confirmation=>'qwerty1234',
										:confirmed_at=>DateTime.new(2013,1,5,12,25,12),
										:role=>"admin",
									 :created_at=>DateTime.new(2013,1,5,9,12,12),
									 :updated_at=>DateTime.new(2013,1,5,9,12,12))


		p = UserProfile.create(:id=>1,
													 :user_id =>1,			
													 :first_name=>'liwen',
													 :last_name =>'chen',
													 :english_name =>'Rolisa',
													 :birthdate =>Date.new(1987,8,30),
													 :intro =>"Hi, i'm liwen",
													 :created_at=>DateTime.new(2013,1,5,9,12,12),
													 :updated_at=>DateTime.new(2013,1,5,9,12,12))


		(total_users-1).times do |i|

			post_datetime = Faker::Time.between(DateTime.new(2013,1,1,1,1,1),DateTime.new(2015,6,16,23,59,59))
			u =	User.create(:id=>i+2,
										:email=>Faker::Internet.free_email,
										:username=>Faker::Name.name,
										:password=>"qwerty1234",
										:password_confirmation=>"qwerty1234",
										:confirmed_at=>Faker::Time.between(DateTime.new(2013,1,1,16,18,12),DateTime.new(2015,6,16,12,1,1)),
										:role=>"user",
									 :created_at=>post_datetime,
									 :updated_at=>post_datetime)

			p = UserProfile.create(:id=>i+2,
														 :user_id =>i+2,			
														 :first_name=> Faker::Name.first_name,
														 :last_name => Faker::Name.last_name,
														 :english_name => Faker::Name.first_name,
														 :birthdate => Faker::Date.between(Date.new(1981,1,1),Date.new(1989,1,1)),
														 :intro =>Faker::Lorem.paragraph(2),
														 :created_at=>post_datetime,
														 :updated_at=>post_datetime)


		end

		puts "posting the articles"
		total_articles.times do |index|

			# assume the first 20 users would post the articles
			post_user_id = Random.rand(20)+1	
			article_id = index+1

			post_datetime = Faker::Time.between(DateTime.new(2013,1,1,1,1,1),DateTime.new(2015,6,16,23,59,59))

			# user post the article
			article = Article.create(:id=>article_id,
															 :title=>Faker::Name.title,
															 :content=>Faker::Lorem.paragraph,
															 :author_id=>post_user_id,
															 :created_at=>post_datetime,
															 :updated_at=>post_datetime)

			#article associates the category
			associate = (Random.rand(5)>0)? 1 : 2			
			associate.times do
				category_id = Random.rand(6)+1
				ArticleCategoryship.create(:article_id=>article_id,
																	 :category_id=>category_id,
																	 :created_at=>post_datetime,
																	 :updated_at=>post_datetime)

			end				

		end 

		puts "viewing the articles"
		total_views.times do |v|
			view_user_id = Random.rand(total_view_users)+1
			article_id = Random.rand(total_articles)+1
			post_datetime = Faker::Time.between(DateTime.new(2013,1,1,1,1,1),DateTime.new(2015,6,16,23,59,59))

			ArticleView.create(:id=>v+1,
													:user_id=>view_user_id,
													:article_id=>article_id,
 												  :created_at=>post_datetime,
 												  :updated_at=>post_datetime)


		end

		puts "commenting the articles"
		total_comments.times do |k|
			reply_user_id = Random.rand(total_comment_users)+1
			article_id = Random.rand(total_articles)+1
			post_datetime = Faker::Time.between(DateTime.new(2013,1,1,1,1,1),DateTime.new(2015,6,16,23,59,59))
			Comment.create(:id => k+1,
										 :content=>Faker::Lorem.sentence, 
										 :user_id=>reply_user_id, 
										 :article_id => article_id,
									  :created_at=>post_datetime,
									  :updated_at=>post_datetime)


		end


	end
end 



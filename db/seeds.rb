# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

10.times do |index|
	# User.create(:email=>Faker::Internet.email,:username=>Faker::Name.name,:password=>"qwerty1234",:password_confirmation=>"qwerty1234",:confirmed_at=>Time.now)


end

Category.destroy_all
Category.create(:name=>"Baseball",:intro=>"Curry wins Labron")
Category.create(:name=>"Baskball",:intro=>"Ichiro go 3000 hits")
Category.create(:name=>"Math",:intro=>"Math is beautiful")
Category.create(:name=>"Computer",:intro=>Faker::Lorem.sentences)
Category.create(:name=>"Physics",:intro=>Faker::Lorem.sentences)
Category.create(:name=>"English",:intro=>Faker::Lorem.sentences)



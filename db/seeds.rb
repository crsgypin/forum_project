# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Category.destroy_all
Category.create(:id=>1, :name=>"Baseball",:intro=>"Curry wins Labron")
Category.create(:id=>2, :name=>"Baskball",:intro=>"Ichiro go 3000 hits")
Category.create(:id=>3, :name=>"Math",:intro=>"Math is beautiful")
Category.create(:id=>4, :name=>"Computer",:intro=>Faker::Lorem.sentences)
Category.create(:id=>5, :name=>"Physics",:intro=>Faker::Lorem.sentences)
Category.create(:id=>6, :name=>"English",:intro=>Faker::Lorem.sentences)









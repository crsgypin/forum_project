class Friendship < ActiveRecord::Base
	belongs_to :user
	belongs_to :friend, :class_name => "User"
	belongs_to :friend_relation_tag
#status: pending, inviting, completed, blocked

	def self.friend_status?(me,friend)
		my_friendship(me,friend).status
	end

	def self.invitation_list(me)
		me.friendships.where(:status=>"invited")
	end

	def self.set_status(me,friend,status)
		fs = my_friendship(me,friend)
		fs.status = status
		fs.save
	end

	def self.set_destroy(me,friend)
		fs = my_friendship(me,friend)
		fs.destroy		
	end

	def self.set_relation_tag(me,friend,relation_id)
		fs = my_friendship(me,friend)
		fs.friend_relation_tag_id = relation_id
		fs.save
	end


private 
	def self.my_friendship(me,friend)
		me.friendships.find_or_initialize_by(:friend_id=>friend.id)
	end

end

class Friendship < ActiveRecord::Base
	belongs_to :user
	belongs_to :friend, :class_name => "User"
	belongs_to :friend_relation_tag

#status: pending, inviting, completed, blocked

	def self.friend_status?(me,friend)
		if my_friendship(me,friend)
			my_friendship(me,friend).status
		else
			nil
		end
	end

	def self.invitation_list(me)
		me.friendships.where(:status=>"invited")
	end



	def self.send_invitation(me,friend)
		me.friendships.create(:friend_id=>friend.id,:status =>"pending")
		friend.friendships.create(:friend_id=>me.id,:status =>"invited")
	end

	def self.cancel_invitation(me,friend)
		my_friendship(me,friend).destroy
		friend.friendships.find_by(:friend_id=>me.id).destroy
	end

  def self.accept_invitation(me,friend)
		my_friendship(me,friend).update(:status=>"completed")

		friend_friendship = friend.friendships.find_by(:friend_id=>me.id)		
		friend_friendship.update(:status=>"completed")
  end

  def self.ignore_invitation(me,friend)
		my_friendship(me,friend).update(:status=>"pending")
  end

	def self.reject_invitation(me,friend)
		my_friendship(me,friend).update(:status=>"blocked")		
	end

	def self.block_my_friend(me,friend)
		my_friendship(me,friend).update(:status=>"blocked")		
	end

	def self.unblock_my_friend(me,friend)
		my_friendship(me,friend).update(:status=>"completed")
	end

private 
	def self.my_friendship(me,friend)
		me.friendships.find_by(:friend_id=>friend.id)
	end

end

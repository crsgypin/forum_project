class FriendsController < ApplicationController
	before_action :set_friend, :authenticate_user!

	def send_invitation
		Friendship.send_invitation(current_user,@friend)
	end

	def cancel_invitation
		Friendship.send_invitation(current_user,@friend)
	end

	def accept_invitation
		Friendship.accept_invitation(current_user,@friend)		
	end

	def ignore_invitation
		Friendship.ignore_invitation(current_user,@friend)
	end

	def reject_invitation
		Friendship.reject_invitation(current_user,@friend)
	end

	def block_my_friend
		Friendship.blocks_my_friend(current_user,@friend)
	end

private
	def set_friend
		@friend = User.find(params[:id])
	end

end

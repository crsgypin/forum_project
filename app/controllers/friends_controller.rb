class FriendsController < ApplicationController
	before_action :set_friend, :authenticate_user!

	def send_invitation
		Friendship.send_invitation(current_user,@friend)
		render_js
	end

	def cancel_invitation
		Friendship.cancel_invitation(current_user,@friend)
		render_js
	end

	def accept_invitation
		Friendship.accept_invitation(current_user,@friend)		
		render_js
	end

	def ignore_invitation
		Friendship.ignore_invitation(current_user,@friend)
		render_js
	end

	def reject_invitation
		Friendship.reject_invitation(current_user,@friend)
		render_js
	end

	def block_my_friend
		Friendship.blocks_my_friend(current_user,@friend)
		render_js
	end

	def unblock_my_friend
		Friendship.unblock_my_friend(current_user,@friend)
		render_js		
	end

private
	def set_friend
		@friend = User.find(params[:id])
	end

	def render_js
		@friendship_status = Friendship.friend_status?(current_user,@friend)
		respond_to do |format|
			format.html
			format.js {render 'update_button.js'}
		end
	end

end

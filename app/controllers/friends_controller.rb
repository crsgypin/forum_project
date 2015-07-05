class FriendsController < ApplicationController
	before_action :set_friend, :authenticate_user!

	def send_invitation
		Friendship.set_status(current_user,@friend,"pending")		
		Friendship.set_status(@friend, current_user,"invited")	
		render_js
	end

	def cancel_invitation
		Friendship.set_destroy(current_user,@friend)
		Friendship.set_destroy(@friend,current_user)
		render_js
	end

	def accept_invitation
		Friendship.set_status(current_user,@friend,"completed")		
		Friendship.set_status(@friend,current_user,"completed")	
		redirect_to friends_user_path(current_user)
	end

	def ignore_invitation
		Friendship.set_status(current_user,@friend,"pending")		
		render_js
	end

	def reject_invitation
		Friendship.set_status(current_user,@friend,"blocking")		
		redirect_to friends_user_path(current_user)
	end

	def block_my_friend
		Friendship.set_status(current_user,@friend,"blocking")
		render_js
	end

	def unblock_my_friend
		Friendship.set_status(current_user,@friend,"completed")
		render_js		
	end

	def select_relation_tag
		fs = current_user.friendships.find_by(:friend_id=>@friend.id)
		fs.friend_relation_tag_id = params[:friend_relation_tag_id]
		fs.save
		render :text => ""
	end


private
	def set_friend
		@friend = User.find(params[:id])
	end

	def relation_params
		params.require(:friendship).permit(:friend_relation_tag_id)
	end

	def render_js
		@friendship_status = Friendship.friend_status?(current_user,@friend)
		respond_to do |format|
			format.html
			format.js {render 'update_button.js'}
		end
	end

end

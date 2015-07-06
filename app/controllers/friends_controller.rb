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
		render_js
	end

	def ignore_invitation
		Friendship.set_status(current_user,@friend,"pending")		
		render_js
	end

	def block_my_friend

		Friendship.set_status(current_user,@friend,"block")
		render_js
	end

	def unblock_my_friend
		Friendship.set_status(current_user,@friend,"completed")
		render_js
	end

	def select_relation_tag
		Friendship.set_relation_tag(current_user,@friend,params[:friend_relation_tag_id])
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
			format.js {
				if params[:user]
					@friendships = current_user.friendships
					@completed_friendships = @friendships.map{|fs| fs if fs.status=="completed"}.compact
					@invited_friendships = @friendships.map{|fs| fs if fs.status=="invited"}.compact
					@other_friendships = @friendships - @invited_friendships - @completed_friendships				

					render 'users/friends_update.js'
				else
					render 'friends/update_button.js'
				end
			}
		end
	end
end

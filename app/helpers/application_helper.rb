module ApplicationHelper

	def get_serial(collection, index)
		params[:page].to_i * collection.limit_value + index + 1
	end
	
	def avatar_url(user)
		gravatar_id = Digest::MD5.hexdigest(user.email)
		"http://gravatar.com/avatar/#{gravatar_id}"
	end

end

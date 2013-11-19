module UsersHelper

  # Returns the Gravatar (http://gravatar.com/) for the given user.
	def gravatar_for(user, options = { size: 100 })
  		gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
  		size = options[:size]
  		gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
  		image_tag(gravatar_url, alt: user.name, class: "gravatar")
	end

	def guest_user
		@guest_user = User.new(name: "Anonymus", email: "my.blog.sitl@gmail.com")
	end

	def blog_user(comment)
		@blog_user = User.find_by_id(comment.user_id)
	end
end
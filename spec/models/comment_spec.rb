require 'spec_helper'

describe Comment do
  before do
  	@user = User.create!(name: "Example User", email: "user@example.com",
                     password: "foobar", password_confirmation: "foobar")

	 	@post = @user.posts.create!(title: "Hello", content: "My Name Is", tag_list: "#Artem,#Demko")

	 	@comment = @post.comments.create!(content: "My first comment")
	end

	subject { @comment }

	it { should respond_to(:content) }

	describe "When content is not present" do
	 	before { @comment.content = " " }
	 	it { should_not be_valid }
	end

	describe "When user_id is nil" do
	 	before { @comment.user_id = nil }
	 	it { should be_valid }
	end
end

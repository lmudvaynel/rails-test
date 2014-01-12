require 'spec_helper'

describe Post do

  before do
  	@user = User.create!(name: "Example User", email: "user@example.com",
                     password: "foobar", password_confirmation: "foobar")

	 	@post = @user.posts.create!(title: "Hello", content: "My Name Is", tag_list: "#Artem,#Demko")
	end

	subject { @post }

	it { should respond_to(:title) }
	it { should respond_to(:content) }
	it { should respond_to(:tag_list) }


	it { should be_valid }

	describe "When title is not present" do
	 	before { @post.title = " " }
	 	it { should_not be_valid }
	end

	describe "When content is not present" do
	 	before { @post.content = " " }
	 	it { should_not be_valid }
	end

	describe "When tags is not present" do
	 	before { @post.tag_list = " " }
	 	it { should_not be_valid }
	end

	describe "When user_id is nil" do
	 	before { @post.user_id = nil }
	 	it { should_not be_valid }
	end

	describe "When title is invalid" do
		it "should be invalid" do
			long_title="a"*101
			titles = ["aq","da","ds","#{long_title}"]
			titles.each do |invalid_titles|
				@post.title = invalid_titles
				@post.should_not be_valid
			end
		end
	end

	describe "When title is valid" do
		it "should be valid" do
			titles = ["Hello First Post", "Street 312"]
			titles.each do |valid_titles|
				@post.title = valid_titles
				@post.should be_valid
			end
		end
	end

	describe "When tags are invalid" do
		it "should be invalid" do
	 		tags = %w[#fsaf.#safsaf $fasd,#5235 wfewf,wfeewf #csdfdf.,#$dsgdsg]
	 		tags.each do |invalid_tags|
	 			@post.tag_list = invalid_tags
	 			@post.should_not be_valid
	 		end
	 	end
	end

	describe "When tags are valid" do
		it "should be valid" do
	 		tags = %w[#fsaf,#safsaf #5235 #6436,#5235,#325235]
	 		tags.each do |valid_tags|
	 			@post.tag_list = valid_tags
	 			@post.should be_valid
	 		end
	 	end
	end
end
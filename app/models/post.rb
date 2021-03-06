class Post < ActiveRecord::Base
  attr_accessible :content, :title, :tag_list
  acts_as_taggable_on :tags
  acts_as_taggable

  validates :user_id, presence: true

  belongs_to :user

  has_many :comments, dependent: :destroy

  default_scope order: 'posts.created_at DESC'

  validates :title, length: { minimum: 3,  maximum: 100}, presence: true

  validates :content, length: { minimum: 10}, presence: true

  VALID_TAG_REGEX = /\A#[a-zA-Z\d]+([a-zA-Z\d]|(, #))+\z/i
  validates :tag_list, format: { with: VALID_TAG_REGEX }, allow_blank: true

  def self.search(search)
  	if search
   	  where("content LIKE ?", "%#{search}%")
 	  else
   	  find(:all)
  	end
  end
  
end
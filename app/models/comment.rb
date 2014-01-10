class Comment < ActiveRecord::Base
 attr_accessible :content, :user_id

 belongs_to :post
 belongs_to :user

end
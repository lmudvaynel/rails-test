class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation
  has_secure_password
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy


  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token

  VALID_NAME_REGEX = /\A[a-zA-Z]+[a-zA-Z]+\z/i
  validates :name, presence: true,
    		format: { with: VALID_NAME_REGEX },
  			length: { maximum: 50} 

  VALID_EMAIL_REGEX = /\A[a-z\d]+([a-z\d]|([-._][a-z\d]))+@[a-z\d\-]+\.[a-z]+\z/i
  validates :email, presence: true,
  			format: { with: VALID_EMAIL_REGEX },
  			uniqueness: { case_sensitive: false }

  validates :password, presence: true,
  			length: { minimum: 6 }

  validates :password_confirmation, presence: true

  def self.search(search)
    if search
      where('name LIKE ?', "%#{search}%")
    else
      find(:all)
    end
  end

  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end


end

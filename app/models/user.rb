class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :statuses
  has_many :user_friendships
  has_many :friends, through: :user_friendships


  validates :first_name, presence: true # makes sure the first name is entered
  validates :last_name, presence: true # makes sure the last name is entered
  validates :profile_name, presence: true, uniqueness: true, format: {with: /\A[a-zA-Z0-9_-]+\z/, message: 'must not contain any spaces.'}


  def user_name
  	"#{profile_name}"
  end

  def full_name
  	"#{first_name} #{last_name}"
  end
  
  def to_param
    profile_name
  end

  def gravatar_url
    stripped_email = email.strip #remove any spaces before and after
    downcased_email = stripped_email.downcase
    hash = Digest::MD5.hexdigest(downcased_email)
    "http://gravatar.com/avatar/#{hash}" #last expression in the method
  end

end

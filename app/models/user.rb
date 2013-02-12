class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :database_authenticatable,
  # :lockable, :timeoutable and :omniauthable, :recoverable, :rememberable, :trackable, :validatable ,:registerable,
  devise :token_authenticatable


  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :current_latitude, :current_longitude, :facebook_access_token, :fullname, :user_facebook_uid
  # attr_accessible :title, :body

  #validates_presence_of :facebook_access_token
end

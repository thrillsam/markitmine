class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

   has_many :copyrights
   has_one :instagram_user

    def self.authenticate(email, password)
  	  user = find_by_email(email)
  	  if user && user.encrypted_password == BCrypt::Engine.hash_secret(password, user.encrypted_password)
  	    user
  	  else
  	    nil
  	  end
	   end


end

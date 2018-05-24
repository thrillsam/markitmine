class ApiUserAuthentication
	def self.sign_in(email,password)
  		errors = nil
      user = User.find_by('email LIKE :email', email: email)
  		if user.present?
  			if (User.authenticate(email,password) == user)
  				errors = nil
  			elsif (User.authenticate(email,password) == nil)
  				errors = "Invalid Password"
  			else
  				errors = "Please Contact Tech Team"
  			end
	  	else
  			errors = "User not Found"
	  	end

  		return errors,user
  	end

  	def self.create_user(email,password,password_confirmation,mobile,name)
      errors = nil
      user = User.find_by(email: email)
      @user = User.create(email: email,password: password,password_confirmation: password_confirmation,contact_number: mobile,name: name)
      # @user.confirmation_token = Devise.friendly_token[0, 20]
      if user.present?
        errors = "Your Email-Id is already registered with us!"
      end
  		return errors, @user
  	end

  	def self.create_auth_token_device(device_id,user)
      device_config = DeviceConfig.find_by(:device_uuid => device_id)
      unless device_config
        result = DeviceConfig.create(device_uuid: device_id, user_id: user.id, user_auth_token: Devise.friendly_token)
      else
        result = device_config.update(user_auth_token: Devise.friendly_token, user_id: user.id)
      end
      return (device_config.present? ? device_config : result)
    end

  	def self.forgot_password(email)
  		errors = nil
  		user = User.find_by(email: email)
  		unless user
  			errors = "Email address not found/Invalid email address"
  		else
  			user.reset_password_token = Devise.friendly_token[0,20]
	      	user.reset_password_sent_at = DateTime.now
	      	user.generate_authentication_token!
	      	user.save
	        # EmailNotifier.reset_password(user).deliver
  		end
  		return errors, user
  	end
end
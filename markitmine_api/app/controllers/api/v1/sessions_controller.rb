class Api::V1::SessionsController < MarkitmineApi::ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_api_user_token!, :only => [:destroy]
  skip_before_action :authenticate_api_user!, :except => [:destroy]

	  def sign_in
	    errors, @user = ApiUserAuthentication.sign_in(params[:email].downcase, params[:password])
	    unless errors
	      @device_token = ApiUserAuthentication.create_auth_token_device(params[:device_uuid], @user) if params[:device_uuid].present?
	      render template: '/api/v1/sessions/user.jbuilder', status: 200
	    else
	      if errors == "Please confirm your account"
	        render json: {errors: errors, user_id: @user.id}, status: 428
	      else
	        render json: {errors: errors}, status: 422
	      end
	    end
	  end

	  def sign_up
	    errors, @user =  ApiUserAuthentication.create_user(params[:email].downcase, params[:password], params[:password_confirmation], params[:contact_number], params[:name])
	    unless errors
	      @device_token = ApiUserAuthentication.create_auth_token_device(params[:device_uuid], @user) if params[:device_uuid].present?
	      render template: '/api/v1/sessions/user.jbuilder', status: 200
	    else
	      render json: {errors: errors}, status: 422
	    end
	  end

	  def forgot_password
	    errors, @user = ApiUserAuthentication.forgot_password(params[:email].downcase)
	    unless errors
	      render json: {message: "Password reset email sent successfully"}, status: 200
	    else
	      render json: {errors: errors}, status: 204
	    end
	  end

	  def destroy
	    if params[:device_uuid]
	      DeviceConfig.find_by(:device_uuid => params[:device_uuid]).update(:logged_in => false, user_auth_token: nil)
	    end
	    @user.update(auth_token: nil)
	    head 200
	  end

	  def reset_password
	    @user = User.find_by(id: params[:user_id])
	    if @user.present?
	      if @user.update(password: params[:password], password_confirmation: params[:password])
	        render json: {message: "Password updated successfully"}, status: 200
	      else
	        render json: {errors: "Something went wrong"}, status: 422
	      end
	    else
	      render json: {errors: "No User found"}, status: 204
	    end
	  end

	  private
	  def user_params
	    params.require(:user).permit(:name, :email, :password, :contact_number, :password_confirmation, :encrypted_password, :password_digest)
	  end

end
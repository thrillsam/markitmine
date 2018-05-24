class Api::V1::PhotosController < MarkitmineApi::ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_api_user_token!, :only => [:destroy]
  skip_before_action :authenticate_api_user!, :except => [:destroy]
  respond_to :json

  def instagram
    # respond_to do |format|
      # format.json {render json: {message: 'hi'}, status: 200}
      render partial: '/api/v1/photos/instagram.json.jbuilder', status: 200
    # end
    # respond_with Copyright.last
  end

  def upload_image
    # params[:copyright] = params
    @copyright = Copyright.new(name: params[:name], image: params[:image])
    @copyright.date = Date.today
    @copyright.type = "image"
    # respond_to do |format|
      if @copyright.save
        # format.json {render json: {message: ''}, status: 200}
        render template: '/api/v1/photos/upload_image.jbuilder', status: 200
      else
        format.json {render json: {message: 'something went wrong'}, status: 422}
      end
    # end

  end

  def facebook
  end

end

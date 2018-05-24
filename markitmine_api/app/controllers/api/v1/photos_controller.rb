class Api::V1::PhotosController < MarkitmineApi::ApplicationController
  respond_to :json

  def instagram
    # respond_to do |format|
      # format.json {render json: {message: 'hi'}, status: 200}
      render partial: '/api/v1/photos/instagram.json.jbuilder', status: 200
    # end
    # respond_with Copyright.last
  end

  def facebook
  end
end

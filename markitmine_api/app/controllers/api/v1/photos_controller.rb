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
    params[:copyright] = params
    params[:copyright][:tags] = Digest::SHA2.hexdigest(File.binread(params[:image].tempfile))
    unless Copyright.where(tags: params[:copyright][:tags]).any?
      @copyright = Copyright.new(name: params[:name], image: params[:image], user_id: params[:user_id].to_i, type_of_file: 'image', tags: params[:copyright][:tags], source: "image")
      @copyright.uploaded_date = Date.today
        if @copyright.save
          add_transaction(@copyright.tags)
          render template: '/api/v1/photos/upload_image.jbuilder', status: 200
        else
          format.json {render json: {message: 'something went wrong'}, status: 422}
        end
    else
      render json: {message: 'Image already exists'}, status: 422
    end
  end

  def all_images
    if params[:user_id].present?
      @copyrights = Copyright.where(user_id: params[:user_id])
      if @copyrights.present?
        render template: '/api/v1/photos/all_images.jbuilder', status: 200
      else
        render json: {errors: "No images found"}, status: 704
      end
    else
      render json: {errors: "User not found"}, status: 422
    end
  end

  def facebook
  end

  def add_transaction(tags)
    url = URI("http://aedd5017.ngrok.io/addtransaction")

    http = Net::HTTP.new(url.host, url.port)

    request = Net::HTTP::Post.new(url)
    request["content-type"] = 'multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW'
    request["cache-control"] = 'no-cache'
    request["postman-token"] = 'dfe3c0df-ee40-bffc-da1d-43e9ab813639'
    request.body = {name: Copyright.find_by(tags: tags).user.email, media: tags}.to_json

    response = http.request(request)
    puts response.read_body
  end

end

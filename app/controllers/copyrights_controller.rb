require 'net/http'
class CopyrightsController < ApplicationController
  before_action :set_copyright, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token
  skip_before_action :authenticate_user!
  include Devise::Controllers::Helpers
    helper_method :current_user

  include Devise::Controllers::Helpers

  helper_method :current_user

  # GET /copyrights
  # GET /copyrights.json
  def index
    @copyrights = Copyright.all
  end

  # GET /copyrights/1
  # GET /copyrights/1.json
  def show
  end

  # GET /copyrights/new
  def new
    @copyright = Copyright.new
  end

  # GET /copyrights/1/edit
  def edit
  end

  # POST /copyrights
  # POST /copyrights.json
  def create
    params[:copyright] = params
    params[:copyright][:tags] = Digest::SHA2.hexdigest(File.binread(params[:image].tempfile))
    unless Copyright.where(tags: params[:copyright][:tags]).any?
     @copyright = Copyright.new(copyright_params)
     respond_to do |format|
       if @copyright.save
         add_transaction(@copyright.tags)
         format.html { redirect_to copyrights_url, notice: 'Copyright was successfully created.' } 
       else
         format.html { render :new }
         format.json { render json: @copyright.errors, status: :unprocessable_entity }
       end
     end
    else
      redirect_back fallback_location: "/copyrights", alert: "Image already exists"
    end
  end

  # PATCH/PUT /copyrights/1
  # PATCH/PUT /copyrights/1.json
  def update
    respond_to do |format|
      if @copyright.update(copyright_params)
        format.html { redirect_to @copyright, notice: 'Copyright was successfully updated.' }
        format.json { render :show, status: :ok, location: @copyright }
      else
        format.html { render :edit }
        format.json { render json: @copyright.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /copyrights/1
  # DELETE /copyrights/1.json
  def destroy
    @copyright.destroy
    respond_to do |format|
      format.html { redirect_to copyrights_url, notice: 'Copyright was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def get_access_token
    url = URI("http://aedd5017.ngrok.io/authorize_user")

    http = Net::HTTP.new(url.host, url.port)

    request = Net::HTTP::Get.new(url)
    request["cache-control"] = 'no-cache'
    request["postman-token"] = '4bab54b3-a698-d1ac-d7b0-6c15d41cc7ca'

    response = http.request(request)
    puts response.read_body
    binding.pry
    url2 = response.read_body
    url2.slice!('Found. Redirecting to ')
    binding.pry
    url = URI("#{url2}")

    http = Net::HTTP.new(url.host, url.port)

    request = Net::HTTP::Get.new(url)
    request["cache-control"] = 'no-cache'
    request["postman-token"] = '4bab54b3-a698-d1ac-d7b0-6c15d41cc7ca'

    response = http.request(request)
    binding.pry

    puts response.read_body
    InstagramUser.create(user_id: current_user.id, accesstoken: response)
    render body: nil
  end

  def instagram_api
    # binding.pry
    url = URI('http://aedd5017.ngrok.io/instapictures')
    http = Net::HTTP.new(url.host, url.port)
    # http.use_ssl = true
    # http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Post.new(url, 'Content-Type' => 'application/json')
    # request["acc"] = Rails.application.secrets.mixpanel_api_token
    # request["content-type"] = 'application/x-www-form-urlencoded'
    request["cache-control"] = 'no-cache'
    request.body = {accesstoken: current_user.instagram_user.access_key}.to_json
    @response = JSON.parse(http.request(request).read_body)
    images = @response["data"]
    images.each do |image|
      puts image
      image_url = image["images"]["standard_resolution"]["url"]
      id      = image["caption"]["id"]
      source  = 'instagram'
      uploaded_date = Date.jd(image["caption"]["created_time"].to_i)
      puts image_url
      unless Copyright.find_by(uploaded_id: id).present?
        copyright = Copyright.create(uploaded_id: id, photo_url: image_url, user_id: current_user.id, source: source)
        add_transaction(copyright.tags)
      end
      # a.save
      # puts a.errors.messages
    end
    render body: nil
  end

  def transaction_details
    user_id = current_user.id
    url = URI("http://aedd5017.ngrok.io/usertransactions?userid=debayan")

    http = Net::HTTP.new(url.host, url.port)

    request = Net::HTTP::Get.new(url)
    request["cache-control"] = 'no-cache'
    request["postman-token"] = '29e3a29f-1b84-bf0a-4406-965ac77bec39'

    response = http.request(request)
    response = JSON.parse(response.read_body)
    puts response
    render body: nil
  end

  def add_transaction(tags)
    url = URI("http://aedd5017.ngrok.io/addtransaction")

    http = Net::HTTP.new(url.host, url.port)

    request = Net::HTTP::Post.new(url)
    request["content-type"] = 'multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW'
    request["cache-control"] = 'no-cache'
    request["postman-token"] = 'dfe3c0df-ee40-bffc-da1d-43e9ab813639'
    request.body = {name: current_user.email, media: tags}.to_json

    response = http.request(request)
    puts response.read_body
  end

  def pending_transactions
    url = URI("http://aedd5017.ngrok.io/pendingtransactions")

    http = Net::HTTP.new(url.host, url.port)

    request = Net::HTTP::Get.new(url)
    request["cache-control"] = 'no-cache'
    request["postman-token"] = '54f186e1-b992-2dc9-e58f-22be4ed3b943'

    response = http.request(request)
    puts response.read_body
    response = JSON.parse(response.read_body)
    puts response
    render body: nil
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_copyright
      @copyright = Copyright.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def copyright_params
      params.require(:copyright).permit(:name, :image, :user_id, :date, :type_of_file, :tags, :uploaded_date, :source)
    end
end

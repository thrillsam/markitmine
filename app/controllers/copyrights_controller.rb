require 'net/http'
class CopyrightsController < ApplicationController
  before_action :set_copyright, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token
  skip_before_action :authenticate_user!


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
    @copyright = Copyright.new(copyright_params)

    respond_to do |format|
      if @copyright.save
        format.html { redirect_to @copyright, notice: 'Copyright was successfully created.' }
        format.json { render :show, status: :created, location: @copyright }
      else
        format.html { render :new }
        format.json { render json: @copyright.errors, status: :unprocessable_entity }
      end
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

  def instagram_api
    url = URI('http://c2de105c.ngrok.io/instapictures')
    http = Net::HTTP.new(url.host, url.port)
    # http.use_ssl = true
    # http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Post.new(url, 'Content-Type' => 'application/json')
    # request["acc"] = Rails.application.secrets.mixpanel_api_token
    # request["content-type"] = 'application/x-www-form-urlencoded'
    request["cache-control"] = 'no-cache'
    request.body = {accesstoken: '4323973862.52c48c5.e83c8c761bef4bf89eb26f578655fde4'}.to_json
    @response = JSON.parse(http.request(request).read_body)
    images = @response["data"]
    images.each do |image|
      image_url = image["user"]["profile_picture"]
      puts image_url
      Copyright.create(name: 'aaa', photo_url: URI.parse(image_url))
    end
    render body: nil
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_copyright
      @copyright = Copyright.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def copyright_params
      params.require(:copyright).permit(:name, :image)
    end
end

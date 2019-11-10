class ShortUrlsController < ApplicationController

  # Since we're working on an API, we don't have authenticity tokens
  skip_before_action :verify_authenticity_token

  def new
    @short_url = ShortUrl.new
  end

  def index
    @short_urls = ShortUrl.all
    render json: @short_urls
  end

  def create
    @shorturl = ShortUrl.new(short_url_params)
    if (!@shorturl.save)
      render json @short_url.errors.full_messages, status: 422
    else 
      render :show
    end
  end

  def show
    @short_url = ShortUrl.find(params[:id])
    render json: @short_url
  end

  private
  def short_url_params
    params.require(:short_url).permit(:full_url)
  end

end
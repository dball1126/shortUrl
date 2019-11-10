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
    @short_url = ShortUrl.create(short_url_params)
    
    if (!@short_url.save)
      render json: @short_url.errors.full_messages, status: 422
    else 
      render json: @short_url
    end
  end

  def show
    @short_url = ShortUrl.find(params[:id])
    
    redirect_to @short_url.full_url
  end

  private
  def short_url_params
    params.permit(:full_url, :short_code, :title)
  end

end
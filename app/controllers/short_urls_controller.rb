class ShortUrlsController < ApplicationController

  # Since we're working on an API, we don't have authenticity tokens
  skip_before_action :verify_authenticity_token

  def new
    @short_url = ShortUrl.new
  end

  def index
    @short_urls = ShortUrl.all
  end

  def create
  end

  def show
    @short_url = ShortUrl.find(params[:id])
  end

  private
  def short_url_params
    params.require(:short_url).permit(:full_url)
  end

end
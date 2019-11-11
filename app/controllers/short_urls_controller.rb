class ShortUrlsController < ApplicationController

  # Since we're working on an API, we don't have authenticity tokens
  skip_before_action :verify_authenticity_token

  def new
    @short_url = ShortUrl.new
  end

  def index
    
    @short_urls = ShortUrl.limit(100)
    @short_urls = public_attributes(@short_urls)
    render json: {urls: @short_urls}
  end

  def update
    @short_url = ShortUrl.find_by(id: params[:id])
    if @short_url.update_attributes(short_url_params)
      render json: @short_url 
    else
      render json: @short_url.errors.full_messages, status: 422
    end
  end

  def create
    @short_url = ShortUrl.create(short_url_params)
    
    if (@short_url.save)
      
      render json: {title: @short_url.title, full_url: @short_url.full_url, short_code: @short_url.short_code, click_count: @short_url.click_count}
    else
       
      render json: {errors: @short_url.errors.full_messages}
    end
  end

  def show
    @short_url = ShortUrl.find_by(short_code: params[:id])
    if (@short_url)
      @short_url.click_count += 1
      redirect_to @short_url.full_url, format: json
    else 
      render json: {error: 'Url not found'}, status: :not_found
    end
  end

  private
  def short_url_params
    params.permit(:full_url, :short_code, :title, :click_count)
  end

  def public_attributes(short_urls)
    arr = []
    short_urls.each do |url|
      arr << {title: url.title, short_code: url.short_code, full_url: url.full_url, click_count: url.click_count}
    end
    arr
  end
end
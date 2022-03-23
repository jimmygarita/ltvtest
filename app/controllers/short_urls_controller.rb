class ShortUrlsController < ApplicationController

  # Since we're working on an API, we don't have authenticity tokens
  skip_before_action :verify_authenticity_token

  def index
    urls = ShortUrl.order(click_count: :desc).limit(100)
    render status: 200, json: { urls: urls.map{ |u| u.short_code } }
  end

  def create
  end

  def show
    short_url = ShortUrl.find_by_short_code params[:id]
    if short_url
      short_url.update(click_count: (short_url.click_count + 1))
      redirect_to short_url.full_url, status: 301
    else
      render status: 404, plain: 'Not found'
    end
  end

end

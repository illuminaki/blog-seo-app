class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :set_robots_header

  private

  def set_robots_header
    if Rails.env.production?
      response.headers['X-Robots-Tag'] = 'all'
    else
      response.headers['X-Robots-Tag'] = 'noindex, nofollow'
    end
  end

end

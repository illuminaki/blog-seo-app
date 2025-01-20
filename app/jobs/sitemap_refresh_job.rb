class SitemapRefreshJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Regenerate the sitemap
    SitemapGenerator::Sitemap.create
  end
end

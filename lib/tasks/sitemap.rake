namespace :sitemap do
    desc "Regenerate the sitemap"
    task refresh: :environment do
      SitemapGenerator::Sitemap.create
    end
end
  
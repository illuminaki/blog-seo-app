# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "http://localhost:3000" # Cambia a tu dominio real en producción

SitemapGenerator::Sitemap.create do
  # Agrega todas las páginas de los artículos
  Article.find_each do |article|
    add article_path(article), lastmod: article.updated_at
  end
end
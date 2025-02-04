class Article < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  validates :title, :content, presence: true

  has_one_attached :image

  after_commit :convert_image_to_webp, if: -> { image.attached? }

  def should_generate_new_friendly_id?
    title_changed? || super
  end

  def optimized_image
    image.variant(resize_to_limit: [800, 800], format: :webp).processed
  end

  private

  def convert_image_to_webp
    return unless image.attached?
  
    require "image_processing/vips"
  
    # Procesa la imagen y genera un archivo temporal
    processed_image = ImageProcessing::Vips
                        .source(image.download)
                        .convert("webp")
                        .call
  
    # Abre el archivo procesado y adjunta el contenido
    File.open(processed_image, "rb") do |file|
      image.attach(
        io: file,
        filename: "#{File.basename(image.filename.to_s, '.*')}.webp",
        content_type: "image/webp"
      )
    end
    File.unlink(processed_image)
    
    end
  end


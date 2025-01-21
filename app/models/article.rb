class Article < ApplicationRecord
    extend FriendlyId
    friendly_id :title, use: :slugged
  
    validates :title, :content, presence: true

    has_one_attached :image
  
    def should_generate_new_friendly_id?
      title_changed? || super
    end

    def optimized_image
      image.variant(resize_to_limit: [800, 800], format: :webp).processed
    end
    
  end
  
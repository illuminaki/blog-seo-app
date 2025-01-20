class Article < ApplicationRecord
    extend FriendlyId
    friendly_id :title, use: :slugged
  
    validates :title, :content, presence: true
  
    def should_generate_new_friendly_id?
      title_changed? || super
    end
  end
  
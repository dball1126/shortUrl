class ShortUrl < ApplicationRecord

  CHARACTERS = [*'0'..'9', *'a'..'z', *'A'..'Z'].freeze

  before_save :validate_full_url
  validates :full_url, presence: true

  def short_code
  end

  def update_title!
  end

  private

  def validate_full_url
     self.full_url.include?("http:") || self.full_url.include?("https:")
  end
end

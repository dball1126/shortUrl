class ShortUrl < ApplicationRecord

  CHARACTERS = [*'0'..'9', *'a'..'z', *'A'..'Z'].freeze

  before_save :validate_full_url
  before_save :short_code
  validates :full_url, presence: true

  def short_code
    self.short_code = "#{id}#{CHARACTERS.sample(3)}#{id}#{CHARACTERS.sample(1)}"
  end

  def update_title!
  end

  private

  def validate_full_url
     self.full_url.include?("http:") || self.full_url.include?("https:")
  end
end

class ShortUrl < ApplicationRecord
  CHARACTERS = [*'0'..'9', *'a'..'z', *'A'..'Z'].freeze

  validates :full_url, presence: true
  validate :validate_full_url

  before_save :short_code
  before_save :update_title!

  def short_code
    return nil if id == nil
    string = ""
    length = id.to_s.length
    main = id
    
    while main > 0
      string += CHARACTERS[(main % 10) + 10]
      main = main / 10
    end
    self.short_code = string + "#{CHARACTERS.sample(6 % string.length).join("")}"
    
  end

  def update_title!
    
    self.title = title
  end
  private
  def validate_full_url
     if(!(self.full_url.include?("http:") || self.full_url.include?("https:")))
      errors.add(:full_url, "is not a valid url")
      false
     end
      true
  end
end

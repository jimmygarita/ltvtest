class ShortUrl < ApplicationRecord

  CHARACTERS = [*'0'..'9', *'a'..'z', *'A'..'Z'].freeze

  validate :validate_full_url
  validates_uniqueness_of :full_url, case_sensitive: true
  validates :full_url, presence: { message: "can't be blank" }

  def short_code
  end

  def update_title!
  end

  private

  def validate_full_url
    if self.full_url.blank?
      errors.add(:full_url, "full_url can't be blank")
    else
      uri = URI.parse(self.full_url)
      errors.add(:full_url, 'is not a valid url') unless uri.is_a?(URI::HTTP) && !uri.host.nil?
    end
  rescue URI::InvalidURIError => e
    errors.add(:full_url, 'is not a valid url')
  end

end

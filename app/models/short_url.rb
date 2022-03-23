class ShortUrl < ApplicationRecord

  include Convertible

  after_save :set_short_code

  validate :validate_full_url
  validates_uniqueness_of :full_url, case_sensitive: true
  validates :full_url, presence: { message: "can't be blank" }

  def short_code
    return nil if self.id.nil?
    integer_to_chars_base self.id
  end

  def update_title!
    page = Net::HTTP.get(URI(self.full_url))
    start_title = page.index('<title>')
    end_title = page.index('</title>')
    if start_title & end_title
      title = page[(start_title + 7)...end_title]
      update_column(:title, title)
    end
  end

  def async_create_archive
    Resque.enqueue(ShortUrl, self.id)
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

  def set_short_code
    update_column(:short_code, short_code)
  end

end

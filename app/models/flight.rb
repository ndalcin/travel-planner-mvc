class Flight < ActiveRecord::Base
  has_many :trips
  has_many :users, through: :trips

  def slug
    self.departure_city.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
  end

  def self.find_by_slug(slug)
    self.all.detect {|i| puts i.slug; i.slug == slug}
  end

end

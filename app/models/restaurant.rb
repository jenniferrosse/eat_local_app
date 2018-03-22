class Restaurant < ApplicationRecord
	# attr_accessible :address, :latitude, :longitude
  validates :name, :address, presence: true
  validates :name, :address, uniqueness: true

	geocoded_by :address
	after_validation :geocode, :if => :address_changed?

  # def self.search(search)
  # where("name ILIKE ? OR address ILIKE ? OR website ILIKE ?", "%#{search}%", "%#{search}%", "%#{search}%")
  # end
end

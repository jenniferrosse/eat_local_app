class Restaurant < ActiveRecord::Base
	# attr_accessible :address, :latitude, :longitude
  validates :name, :address, :url, presence: true
  validates :name, :address, :url, uniqueness: true

	geocoded_by :address
	after_validation :geocode, :if => :address_changed?
end

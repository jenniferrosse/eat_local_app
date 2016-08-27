class Restaurant < ActiveRecord::Base
	# attr_accessible :address, :latitude, :longitude
  validates :name, :address, :url, presence: true

	geocoded_by :address
	after_validation :geocode, :if => :address_changed?
end

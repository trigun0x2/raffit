class Home < ActiveRecord::Base
  has_many :items
  has_many :photos
end

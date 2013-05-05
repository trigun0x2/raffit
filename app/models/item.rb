class Item < ActiveRecord::Base
  attr_accessible :close_date, :description, :name, :price, :quantity, :shipping, :tickbuy_max, :tickbuy_min, :ticket, :tickthres_max, :tickthres_min, :user

  belongs_to :users
  has_many :tickets
  has_many :photos
end

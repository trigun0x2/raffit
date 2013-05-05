class Item < ActiveRecord::Base
  attr_accessible :closeDate, :description, :name, :price, :quantity, :shipping, :tickbuy_max, :tickbuy_min, :ticket, :tickthres_max, :tickthres_min, :user

  belongs_to :users
  has_many :tickets
end

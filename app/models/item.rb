class Item < ActiveRecord::Base
  attr_accessible :close_date, :description, :name, :price, :quantity, :shipping, :tickbuy_max, :tickbuy_min, :ticket, :tickthres_max, :tickthres_min, :winning_ticket

  belongs_to :users
  has_many :tickets
  has_many :photos

  validates_presence_of :name, :price, :quantity, :shipping, :close_date
end

class Ticket < ActiveRecord::Base
  attr_accessible :item, :user

  belongs_to :user, :item
end

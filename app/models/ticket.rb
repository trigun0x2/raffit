class Ticket < ActiveRecord::Base
  attr_accessible :item_id, :user_id

  belongs_to :users
  belongs_to :items
end

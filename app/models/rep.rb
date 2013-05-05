class Rep < ActiveRecord::Base
  attr_accessible :user_id, :vote, :voter_id
  belongs_to :users
end

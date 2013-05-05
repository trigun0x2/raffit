class User < ActiveRecord::Base
  authenticates_with_sorcery!
  # attr_accessible :title, :body
  attr_accessible :email, :password, :password_confirmation, :provider, :uid

  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email, :password_confirmation
  validates_uniqueness_of :email

  has_many :items
  has_many :tickets

end

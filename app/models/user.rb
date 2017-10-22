class User < ActiveRecord::Base
  has_many :trips
  has_secure_password
  validates_presence_of :username, :presence => true
  validates_presence_of :password, :presence => true
end

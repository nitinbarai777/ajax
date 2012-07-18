class UserProvider < ActiveRecord::Base
  attr_accessible :email, :mobile_number, :username
  has_many :authorizations
end

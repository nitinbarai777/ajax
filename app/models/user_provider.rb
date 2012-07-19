class UserProvider < ActiveRecord::Base
  attr_accessible :email, :mobile_number, :username
  has_many :authorizations, :dependent => :destroy
  has_many :user_coupons, :dependent => :destroy

  def self.search(search)
    if search
      where('username LIKE ? OR email LIKE ? OR mobile_number LIKE ?', "%#{search}%", "%#{search}%", "%#{search}%")
    else
      scoped
    end
  end
end

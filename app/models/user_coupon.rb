class UserCoupon < ActiveRecord::Base
  belongs_to :user
  belongs_to :user_provider
  belongs_to :coupon
  attr_accessible :error_text, :message, :message_id, :message_status, :provider

  def self.search(search)
    if search
      where('message_status LIKE ? OR provider LIKE ?', "%#{search}%", "%#{search}%")
    else
      scoped
    end
  end

end

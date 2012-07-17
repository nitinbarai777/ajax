class UserCoupon < ActiveRecord::Base
  belongs_to :user
  belongs_to :coupon
  attr_accessible :error_text, :message, :message_id, :message_status
end

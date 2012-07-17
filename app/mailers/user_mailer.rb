class UserMailer < ActionMailer::Base
  default :from => "ryan@railscasts.com"
  
  def registration_confirmation(user)
    @user = user
    
	body = "Dear, #{user.username} <br />

	Your Registration Has Been Done Successfully <br />

	<a href='http://couponmandi.com/'>Please click here to login</a> <br />

	Thank you, <br />

	Couponmadi Team"
    mail(:to => "#{user.username} <#{user.email}>", :subject => "CouponMandi::New registration", :body => body)
  end

  def forgot_password_confirmation(user,new_pass)
    #attachments["rails.png"] = File.read("#{Rails.root}/public/images/rails.png")
	body = "Dear, #{user.username} <br />

	Your Password Has Been Reset Successfully <br />

	Your New Password  is :- #{new_pass} <br />

	<a href='http://couponmandi.com/'>Please click here to login</a> <br />

	Thank you, <br />

	Couponmadi Team"
	#body = "Your new password has been generated as below <br /> Password: #{new_pass}"
    mail(:to => "#{user.username} <#{user.email}>", :subject => "CouponMandi::Password Reset", :body => body)
  end

  def get_coupon_confirmation(user,coupon, body)
    mail(:to => "#{user.username} <#{user.email}>", :subject => "Your coupon code info for Coupon Mandi", :body => body, :content_type => "text/html")
  end

end



class UserMailer < ActionMailer::Base
  default :from => "ryan@railscasts.com"
  
  def registration_confirmation(user)
    @user = user
    #attachments["rails.png"] = File.read("#{Rails.root}/public/images/rails.png")
    mail(:to => "#{user.username} <#{user.email}>", :subject => "CouponMandi::New registration")
  end

  def forgot_password_confirmation(user,new_pass)
    #attachments["rails.png"] = File.read("#{Rails.root}/public/images/rails.png")
	body = "Your new password has been generated as below <br /> Password: #{new_pass}"
    mail(:to => "#{user.username} <#{user.email}>", :subject => "CouponMandi::Password Reset", :body => body)
  end

end



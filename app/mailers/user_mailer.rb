class UserMailer < ActionMailer::Base
  default :from => "ryan@railscasts.com"
  
  def registration_confirmation(user)
    @user = user
    attachments["rails.png"] = File.read("#{Rails.root}/public/images/rails.png")
    mail(:to => "#{user.username} <#{user.email}>", :subject => "Registered")
  end

  def forgot_password_confirmation(user)
    @user = user
    attachments["rails.png"] = File.read("#{Rails.root}/public/images/rails.png")
	body = "Your new password has been generated as below <br /> Password: #{user.password}"
    mail(:to => "#{user.username} <#{user.email}>", :subject => "Password Request", :body => body)
  end

end



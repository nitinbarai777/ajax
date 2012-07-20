class FrontsController < ApplicationController
  layout "fronts"

  def index
    @user_session = UserSession.new
	if !params[:id].nil?
		session[:city_id] = params[:id].to_i
		@o_all = Coupon.search_filterby_city(params[:id].to_i).paginate(:per_page => 9, :page => params[:page])
		@o_all_areas = Area.where(:city_id => session[:city_id])
	elsif !params[:area_id].nil?
		@o_all = Coupon.search_filterby_area(params[:area_id].to_i).paginate(:per_page => 9, :page => params[:page])
		@o_all_areas = Area.where(:city_id => session[:city_id])
	elsif !params[:coupon_id].nil?
	    @o_all = Coupon.where(:id => params[:coupon_id]).paginate(:per_page => 9, :page => params[:page])
		session[:city_id] = nil
	else
	    @o_all = Coupon.paginate(:per_page => 9, :page => params[:page])
		session[:city_id] = nil
	end
  end

  def signin
	@user_session = UserSession.new(params[:user_session])
	if params[:user_session][:username].blank?
		flash[:error_login] = t("general.username_required")
		redirect_to fronts_path
	elsif params[:user_session][:password].blank?
		flash[:error_login] = t("general.password_requied")
		redirect_to fronts_path
	elsif @user_session.save
		session[:user_id] = current_user.id
    	session[:user_provider_id] = nil
		session[:user_provider] = nil
		flash[:success_msg] = t("general.login_successfully")
		redirect_to fronts_path
    else
  		flash[:error_login] = t("general.credentials_not_valid")
	    redirect_to fronts_path
    end
  end

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
	  body = render_to_string(:partial => "fronts/registration_mail", :locals => { :username => @user.username}, :formats => [:html])
	  body = body.html_safe
	  UserMailer.registration_confirmation(@user, body).deliver
      flash[:success_msg] = t("general.successfully_registered")
	  redirect_to fronts_path
    else
      render :action => 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:user][:id])
    if @user.update_attributes(params[:user])
      flash[:success_msg] = t("general.profile_updated_successfully")
   	  redirect_to fronts_path
    else
      render :action => 'edit'
    end
  end

  def forgot_password
	@user = User.new
	if !params[:user].blank?
		if params[:user][:email].blank?
			flash[:error_msg] = t("general.email_required")
			redirect_to :action => "forgot_password"
		elsif user = authenticate_password(params[:user][:email])
			new_pass = SecureRandom.hex(5)
		    user.password = new_pass
		    user.password_confirmation = new_pass
			user.save
			body = render_to_string(:partial => "fronts/forgot_password_mail", :locals => { :username => user.username, :new_pass => new_pass }, :formats => [:html])
			body = body.html_safe
			UserMailer.forgot_password_confirmation(user, new_pass, body).deliver
	  		flash[:success_msg] = t("general.password_has_been_sent_to_your_email_address")
			redirect_to fronts_path
		else
	  		flash[:error_msg] = t("general.no_user_exists_for_provided_email_address")
			redirect_to :action => "forgot_password"
		end
	end
  end	

  def change_password
	if !params[:user].blank?
		if params[:user][:password].blank?
			flash[:error_msg] = t("general.password_required")
			redirect_to :action => "change_password"
		elsif params[:user][:password].to_s != params[:user][:password_confirmation].to_s
			flash[:error_msg] = t("general.password_does_not_match")
			redirect_to :action => "change_password"
		else
			@user = User.find(current_user.id)
			@user.password = params[:user][:password]
			@user.password_confirmation = params[:user][:password_confirmation]
			if @user.save
			  flash[:success_msg] = t("general.password_successfully_updated")
			  redirect_to fronts_path
			else
			  flash[:success_msg] = t("general.password_does_not_updated")
			  render :action => :change_password
			end
		end
	else
		@user = User.new
	end
  end

  def facebook_login
      auth_hash = request.env['omniauth.auth']
	  if session[:user_id]
		redirect_to fronts_path
	  else
		user_provider_id = Authorization.find_or_create(auth_hash)
		# Create the session
		session[:user_id] = user_provider_id
		session[:user_provider_id] = user_provider_id
		session[:user_provider] = 'facebook'
		session[:fb_token] = auth_hash["credentials"]["token"]
	 	redirect_to fronts_path
		#render :text => "Welcome #{auth.inspect}!"
	  end
  end	

  def get_coupon
	unless params[:id].nil?
  	  o_coupon = Coupon.find(params[:id])
		@var_mobile_exists = 0
		if session[:user_provider_id].nil?
			@check_usercoupon = UserCoupon.where(:user_id => current_user.id.to_i, :coupon_id => params[:id].to_i).order("created_at desc").first
		else
			@check_usercoupon = UserCoupon.where(:user_id => session[:user_provider_id], :coupon_id => params[:id].to_i, :provider => 'facebook').order("created_at desc").first
			@mobile_number = UserProvider.find(session[:user_provider_id]).mobile_number
			if @mobile_number == ''
				@var_mobile_exists = 1
			end
		end

		unless @check_usercoupon.blank?
			@tm = (Time.parse(DateTime.now.to_s) - Time.parse(@check_usercoupon.created_at.to_s))/3600
			if @tm > 24
				if @var_mobile_exists == 1
					@response_msg = t("general.provide_mobile_number_to_ getcoupon")
				else
					setUserCoupon(o_coupon)
					@response_msg = t("general.discount_Coupon_sent_email_mobile")
				end
			else
				@response_msg = t("general.get_coupone_after_24_hours")
			end
		else
			if @var_mobile_exists == 1
				@response_msg = t("general.provide_mobile_number_to_ getcoupon")
			else
				setUserCoupon(o_coupon)
				@response_msg = t("general.discount_Coupon_sent_email_mobile")
			end
		end
	else
		@response_msg = t("general.something_is_broken")
	end
  end

  def destroy
    @user_session = UserSession.find
	if @user_session
	    @user_session.destroy
	end
	session[:user_id] = nil
	if session[:user_provider].nil?
		redirect_to fronts_path
	else
		session[:user_provider_id] = nil
	    session[:user_provider] = nil
		base_url = 'http://156.ajax.ntn/'
		redirect_to "https://www.facebook.com/logout.php?access_token=" + session[:fb_token] + "&next=#{base_url}"
	end
  end

  def mobile_edit
	@o_userProvider = UserProvider.find(params[:id])
  end

  def mobile_edit_update
	@o_userProvider = UserProvider.find(params[:user_provider][:id])
    if @o_userProvider.update_attributes(params[:user_provider])
      flash[:success_msg] = t("general.profile_updated_successfully")
   	  redirect_to fronts_path
    end
  end

  def privacypolicy
  end

  def contactus
  end

  def terms
  end

  def nexmo_sms111
  	nexmo = Nexmo::Client.new('07ecc81d', 'c41a5d4e')
  	@text_msg = "Loneliness is not when you have no one with you,Loneliness is when you have everyone but not the one whom you want to be with YOU..!!."
  	response = nexmo.send_message({
  		from: 'Jadi',
		to: "+919824560502",
		text: @text_msg
	})
	if response.success?
  		render :text => "Sent message: #{response.message_id}"
	elsif response.failure?
  		render :text => "Sent message: #{response.error}"
	end
  end


  private
  #set user coupon and send e-mail and SMS to provided user details	
  def setUserCoupon(o_coupon)
	  @o_userCoupon = UserCoupon.new
	  @o_userCoupon.message = 'sample message'
	  @o_userCoupon.message_id = '111'
	  @o_userCoupon.message_status = 'DELIVRD'
	  @o_userCoupon.coupon_id = o_coupon.id
	  if session[:user_provider] == 'facebook'
		@o_userCoupon.provider = 'facebook'
		current_user_provider = UserProvider.find(session[:user_provider_id])
		@o_userCoupon.user_id = current_user_provider.id
	    body = render_to_string(:partial => "fronts/coupon_mail", :locals => { :user => current_user_provider.username, :coupon => o_coupon}, :formats =>
 [:html])			
	  body = body.html_safe
	  UserMailer.get_coupon_confirmation(current_user_provider, o_coupon, body).deliver
	  else	
		@o_userCoupon.user_id = current_user.id
	    body = render_to_string(:partial => "fronts/coupon_mail", :locals => { :user => current_user.username, :coupon => o_coupon}, :formats => [:html])			
	  	body = body.html_safe
	 	UserMailer.get_coupon_confirmation(current_user, o_coupon, body).deliver
	  end
	  @o_userCoupon.save
=begin
		nexmo = Nexmo::Client.new('07ecc81d', 'c41a5d4e')
		@text_msg = "Name: #{coupon.name}, Valid From #{coupon.valid_from} To #{coupon.valid_to}, Discount: - #{coupon.price}%"
		response = nexmo.send_message({
		  from: 'CouponMandi',
		  to: "+91"+"919601150343",
		  text: @text_msg
		})
		if response.success?
		  @o_userCoupon.message_id = response.message_id
		  @o_userCoupon.message_status = "DELIVRD"
		  @o_userCoupon.message = @text_msg
		  @o_userCoupon.save
		elsif response.failure?
		  @o_userCoupon.message_id = response.message_id
		  @o_userCoupon.message_status = "FAILED"
		  @o_userCoupon.message = @text_msg
		  @o_userCoupon.error_text = response.error
		  @o_userCoupon.save
		end
=end
  end
	
end

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
	else
	    @o_all = Coupon.paginate(:per_page => 9, :page => params[:page])
		session[:city_id] = nil
	end
  end

  def signin
	@user_session = UserSession.new(params[:user_session])
	if params[:user_session][:username].blank?
		flash[:error_login] = 'Username Required.'
		redirect_to fronts_path
	elsif params[:user_session][:password].blank?
		flash[:error_login] = 'Password Requied.'
		redirect_to fronts_path
	elsif @user_session.save
		session[:user_id] = current_user.id
		flash[:success_msg] = 'Login successfully.'
		redirect_to fronts_path
    else
  		flash[:error_login] = 'Credentials you entered are not valid.Please check the spelling for both username and password.'
	    redirect_to fronts_path
    end
  end


  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
	  UserMailer.registration_confirmation(@user).deliver
      flash[:success_msg] = "Successfully Registered."
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
      flash[:success_msg] = "Profile updated successfully."
   	  redirect_to fronts_path
    else
      render :action => 'edit'
    end
  end

  def forgot_password
	@user = User.new
	if !params[:user].blank?
		if params[:user][:email].blank?
			flash[:error_msg] = 'Email Required.'
			redirect_to :action => "forgot_password"
		elsif user = authenticate_password(params[:user][:email])
			new_pass = SecureRandom.hex(5)
		    user.password = new_pass
		    user.password_confirmation = new_pass
			user.save
			UserMailer.forgot_password_confirmation(user, new_pass).deliver
	  		flash[:success_msg] = 'Password has been sent to your email address.'
			redirect_to fronts_path
		else
	  		flash[:error_msg] = 'No user exists for provided email address.'
			redirect_to :action => "forgot_password"
		end
	end
  end	

  def change_password
	if !params[:user].blank?
		if params[:user][:password].blank?
			flash[:error_msg] = 'Password Required.'
			redirect_to :action => "change_password"
		elsif params[:user][:password].to_s != params[:user][:password_confirmation].to_s
			flash[:error_msg] = 'Password does not match.'
			redirect_to :action => "change_password"
		else
			@user = User.find(current_user.id)
			@user.password = params[:user][:password]
			@user.password_confirmation = params[:user][:password_confirmation]
			if @user.save
			  flash[:success_msg] = "Password successfully updated"
			  redirect_to fronts_path
			else
			  flash[:success_msg] = "Password does not updated."
			  render :action => :change_password
			end
		end
	else
		@user = User.new
	end
  end


  def facebook_login
	  auth_hash = request.env['omniauth.auth']
	  render :text => auth_hash.inspect
	  if session[:user_id]
		# Means our user is signed in. Add the authorization to the user
		User.find(session[:user_id]).add_provider(auth_hash)
		redirect_to fronts_path
		#render :text => "You can now login using #{auth_hash["provider"].capitalize} too!"
	  else
		# Log him in or sign him up
		auth = Authorization.find_or_create(auth_hash)
	 
		# Create the session
		session[:user_id] = auth.user.id
	 	redirect_to fronts_path
		#render :text => "Welcome #{auth.user.name}!"
	  end
  end	

  def get_coupon
	unless params[:id].nil?
  	  @o_coupon = Coupon.find(params[:id])

	  @o_userCoupon = UserCoupon.new
	  @o_userCoupon.message = 'sample message'
	  @o_userCoupon.message_id = '111'
	  @o_userCoupon.message_status = 'DELIVRD'
	  @o_userCoupon.user_id = current_user.id.to_i
	  @o_userCoupon.coupon_id = params[:id].to_i
	  @o_userCoupon.save

	  body = render_to_string(:partial => "fronts/coupon_mail", :locals => { :user => current_user, :coupon => @o_coupon}, :formats => [:html])
	  body = body.html_safe

	  UserMailer.get_coupon_confirmation(current_user, @o_coupon, body).deliver
	  #flash[:success_msg] = 'The Discount Coupon is emailed to registered Email ID.'
	end	
  end

  # DELETE /user_sessions/1
  # DELETE /user_sessions/1.xml
  def destroy
    @user_session = UserSession.find
    @user_session.destroy
	session[:user_id] = nil

    respond_to do |format|
      format.html { redirect_to(:fronts, :notice => 'Goodbye!') }
      format.xml { head :ok }
    end
  end
  def privacypolicy
  end

  def contactus
  end

  def terms
  end
end

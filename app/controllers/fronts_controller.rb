class FrontsController < ApplicationController
  layout "fronts"
  def index
    @user_session = UserSession.new
	unless params[:id].nil?
		@o_all = Coupon.search_filterby_city(params[:id].to_i).paginate(:per_page => 9, :page => params[:page])
	else
	    @o_all = Coupon.paginate(:per_page => 9, :page => params[:page])
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
		flash[:error_login] = 'Login successfully.'
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
      flash[:notice] = "Successfully Registered."
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
      flash[:notice] = "Profile updated successfully."
   	  redirect_to fronts_path
    else
      render :action => 'edit'
    end
  end

  def forgot_password
	@user = User.new
	if !params[:user].blank?
		if params[:user][:email].blank?
			flash[:error_login] = 'Email Required.'
			redirect_to :action => "forgot_password"
		elsif user = authenticate_password(params[:user][:email])
			UserMailer.forgot_password_confirmation(user).deliver
	  		flash[:error_login] = 'Password sent to your email address'
			redirect_to fronts_path
		else
	  		flash[:error_login] = 'No user exists for provided email address'
			redirect_to :action => "forgot_password"
		end
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

end

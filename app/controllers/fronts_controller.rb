class FrontsController < ApplicationController
  layout "fronts"
  def index
    @user_session = UserSession.new
    @o_all = Coupon.paginate(:per_page => 9, :page => params[:page])
  end

  def create
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

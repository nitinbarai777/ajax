class UserCouponsController < ApplicationController
  # GET /user_coupons
  # GET /user_coupons.json
  def index
    @user_coupons = UserCoupon.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @user_coupons }
    end
  end

  # GET /user_coupons/1
  # GET /user_coupons/1.json
  def show
    @user_coupon = UserCoupon.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user_coupon }
    end
  end

  # GET /user_coupons/new
  # GET /user_coupons/new.json
  def new
    @user_coupon = UserCoupon.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user_coupon }
    end
  end

  # GET /user_coupons/1/edit
  def edit
    @user_coupon = UserCoupon.find(params[:id])
  end

  # POST /user_coupons
  # POST /user_coupons.json
  def create
    @user_coupon = UserCoupon.new(params[:user_coupon])

    respond_to do |format|
      if @user_coupon.save
        format.html { redirect_to @user_coupon, notice: 'User coupon was successfully created.' }
        format.json { render json: @user_coupon, status: :created, location: @user_coupon }
      else
        format.html { render action: "new" }
        format.json { render json: @user_coupon.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /user_coupons/1
  # PUT /user_coupons/1.json
  def update
    @user_coupon = UserCoupon.find(params[:id])

    respond_to do |format|
      if @user_coupon.update_attributes(params[:user_coupon])
        format.html { redirect_to @user_coupon, notice: 'User coupon was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user_coupon.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_coupons/1
  # DELETE /user_coupons/1.json
  def destroy
    @user_coupon = UserCoupon.find(params[:id])
    @user_coupon.destroy

    respond_to do |format|
      format.html { redirect_to user_coupons_url }
      format.json { head :no_content }
    end
  end
end

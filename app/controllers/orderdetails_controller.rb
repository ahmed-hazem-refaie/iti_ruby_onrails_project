class OrderdetailsController < ApplicationController
  before_action :set_orderdetail, only: [:show, :edit, :update, :destroy]

  # GET /orderdetails
  # GET /orderdetails.json
  def index
    @orderdetails = Orderdetail.all
  end

  # GET /orderdetails/1
  # GET /orderdetails/1.json
  def show
  end

  # GET /orderdetails/new
  def new
    @orderdetail = Orderdetail.new
  end

  # GET /orderdetails/1/edit
  def edit
  end

  # POST /orderdetails
  # POST /orderdetails.json
  def create
    @order = Order.find(params[:order_id])
    unless (params[:orderdetail][:item].empty? && params[:orderdetail][:amount].empty? && params[:orderdetail][:price].empty?)
     @orderdetail = (@order.orderdetails.create(params.require(:orderdetail).permit(:item, :amount, :price, :comment))).valid?
      @orderdetail.user=current_user
      respond_to do |format|
        if @orderdetail.save
          
            flash[:success] = "Order details was successfully created."
            format.html { redirect_to :controller => 'orders', :action => 'show',:id => @order.id }
            format.json { render :show, status: :created, location: @orderdetail }
          
        else
          flash[:alert] = "error,cann't save."
          format.html { render :new }
          format.json { render json: @orderdetail.errors, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        flash[:error] = "Please fill all fields."
        format.html { redirect_to :controller => 'orders', :action => 'show',:id => @order.id }
        format.json { render :show, status: :created, location: @orderdetail }
      end
    end
  end

  # PATCH/PUT /orderdetails/1
  # PATCH/PUT /orderdetails/1.json
  def update
    respond_to do |format|
      if @orderdetail.update(orderdetail_params)
        format.html { redirect_to @orderdetail, notice: 'Orderdetail was successfully updated.' }
        format.json { render :show, status: :ok, location: @orderdetail }
      else
        format.html { render :edit }
        format.json { render json: @orderdetail.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orderdetails/1
  # DELETE /orderdetails/1.json
  def destroy
    if (current_user == @orderdetail.user )
        @orderdetail.destroy
    end
    respond_to do |format|
      flash[:info] = "Orderdetail was successfully destroyed."
      format.html { redirect_to :controller => 'orders', :action => 'show',:id => @orderdetail.order_id }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_orderdetail
      @orderdetail = Orderdetail.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def orderdetail_params
      params.require(:orderdetail).permit(:item, :amount, :price, :comment, :user_id, :order_id)
    end
end

class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy, :finish, :invited, :joined]
  before_action :authenticate_user!
  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.paginate(page: params[:page], per_page: 3).where(user:current_user)
    # if params[:search]
    #   @search_results_orders = Order.all[0..10]
    #   @par=params
    #   respond_to do |format|
    #     format.js { render partial: 'search-results'}
    #     # format.json  { render :json => @search_results_orders }
    #   end
    # else
    # @orders = Order.all
    # end
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    @invited_no=@order.notifications.count
    @accepted_no=@order.notifications.where(status:"accepted").count
  end

  def invited
    @invited=Array.new
    if (current_user == @order.user )
      @invited=@order.notifications
    end
    print @invited
    respond_to do |format|
      format.html
      format.js
    end
  end

  def joined
    @joined=Array.new
    if (current_user == @order.user )
       @joined=@order.notifications.where(status:"accepted")
    end
    respond_to do |format|
      format.html
      format.js
    end
  end 

  def finish
      @order.status="finish"
      respond_to do |format|
        if (@order.save)
          format.html { redirect_to orders_url }
          format.json { render :show, status: :created, location: @orderdetail }
        else
          format.html { render :new }
          format.json { render json: @orderdetail.errors, status: :unprocessable_entity }
        end
      end
  end

  # GET /orders/new
  def new
    if params[:request_user]
       @user_all=[]
       @group = Group.find_by({name:params[:request_user]})
       if @group
       @friends = Friendship.where(["group_id = ?", @group])
       @friends.each do |friend|
       @user_all.push(User.where(["id = ?", friend.friend_id]).first);     
      end
    else
      @xx = User.find_by("email = ? OR name = ?", params[:request_user], params[:request_user]);
          if @xx
      @user_all.push(@xx);
          end
    end
      
      respond_to do |format|
        # format.json  { render :json => @user_all }
        format.js { render partial: 'get-users'}
      
      end

    else
    @order = Order.new
    end
  end

  # GET /orders/1/edit
  def edit

  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)
    @order.status="waiting"
    if params[:userid]
    users=User.find(params[:userid])
    @order.users<<(users)
    @order.user_id=current_user.id
    end
   
  

  
# render  plain: params[:userid]
    respond_to do |format|
      if !users
        format.html { redirect_to request.referer, alert: 'No Users Detected!' }
        format.json { render json: @order.errors, status: :unprocessable_entity }

      elsif @order.save
        users.each do |x| 
          n=Notification.find_by({user_id:x.id,order_id:@order.id}); 
          n.body="the #{current_user.email} add #{x.email} To0o this order";
          n.status="bending";
           n.save
             end
        @activity="order for "+@order.order_for+" from "+@order.from
        Activite.create(action:@activity,user:current_user)
        flash[:success] =  'Order was successfully created.'
        format.html { redirect_to @order}
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def order_params
      params.require(:order).permit(:order_for, :from, :mimg,:image)
    end
end

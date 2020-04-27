class GroupsController < ApplicationController
  before_action :set_group, only: [ :edit, :update, :destroy]

  # GET /groups
  # GET /groups.json
  def index
    @groups = current_user.groups
    @group = Group.new
  
  end

  # GET /groups/1
  # GET /groups/1.json
  def show
    @group = Group.find(params[:id])
    if @group.user_id == current_user.id
      @friends = Friendship.where(["group_id = ?", @group])
      @users=[]
      @friends.each do |friend|
      @users.push(User.where(["id = ?", friend.friend_id]).first)
      end
      @groups = current_user.groups
    else
      redirect_to root_path	

      
    end
  
    

  end

  # GET /groups/new
  def new
    @group = Group.new
  end

  # GET /groups/1/edit
  def edit
  end

  # POST /groups
  # POST /groups.json
  def create
    @group = Group.new(group_params)

    respond_to do |format|
      if @group.save
        format.html { redirect_to @group, notice: 'Group was successfully created.' }
        format.json { render :show, status: :created, location: @group }
      else
        format.html { render :new }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /groups/1
  # PATCH/PUT /groups/1.json
  def update
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to @group, notice: 'Group was successfully updated.' }
        format.json { render :show, status: :ok, location: @group }
      else
        format.html { render :edit }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    @group.destroy
    respond_to do |format|
      format.html { redirect_to groups_url, notice: 'Group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  def remove
    f = Friendship.where(["group_id = ? and friend_id = ?", params[:id],params[:friend_id]]).update_all( group_id: nil )
    respond_to do |format|
      format.html { redirect_to group_url, notice: 'Friend was successfully Removed.' }
      format.json { head :no_content }
    end
  end
  def add_friend
    @friend = User.where(["email = ?",params[:search]])
    if @friend.empty?
      flash[:alert] = "Error! : Invalid friend email"
      redirect_to group_url
    else 
      @f = Friendship.where(["user_id = ? and friend_id = ?", current_user.id,@friend.first.id]).update_all( group_id: params[:id])
      puts @f
      puts "heyyyyyy"
      if @f != 0
        respond_to do |format|
          format.html { redirect_to group_url, notice: 'Friend was successfully Added.' }
          format.json { head :no_content }
        end
      else
        flash[:alert] = "Error! : You both are not friends"
        redirect_to group_url
      end
    end
    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group
      @group = Group.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def group_params
      params.require(:group).permit(:name, :user_id)
    end
end

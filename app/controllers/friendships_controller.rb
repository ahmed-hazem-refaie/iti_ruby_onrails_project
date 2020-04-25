class FriendshipsController < ApplicationController
  before_action :set_friendship, only: [:show, :edit, :update, :destroy]

  # GET /friendships
  # GET /friendships.json
  def index
    @friendships = Friendship.all
    p "*********************"
    p Friendship.all
    p "******$$$$"
    # p Friendship.joins(:User).select('User.email, User.name')
    # p Friendship.joins(:User).where('User.id' => 1)
    q= User.find(id=1)
    p "@@@@@@@@@@@@@@@@@@"
    p q.email
    # p Friendship
    # q.first.t_id
    # q.first.t_name
    p "********************"
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
    @friendship = Friendship.new
    # render template: "friendships/new"

  end

  # GET /friendships/1
  # GET /friendships/1.json
  def show
  end

  # GET /friendships/new
  def new
    # user_id:current_user
    # @current_user ||= User.find(session[:user_id]) if session[:user_id]
    @friendship = Friendship.new
    # @friendship.user_id << @current_user.id
  end

  # GET /friendships/1/edit
  def edit
  end

  # POST /friendships
  # POST /friendships.json
  def create
    
    @friendship = Friendship.new(friendship_params)
    @friendship.user_id=current_user.id
    @users=User.all
    @current_user
    respond_to do |format|
      if @friendship.save
        format.html { redirect_to @friendship, notice: 'Friendship was successfully created.' }
        format.json { render :show, status: :created, location: @friendship }
      else
        format.html { render :new }
        format.json { render json: @friendship.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /friendships/1
  # PATCH/PUT /friendships/1.json
  def update
    respond_to do |format|
      if @friendship.update(friendship_params)
        format.html { redirect_to @friendship, notice: 'Friendship was successfully updated.' }
        format.json { render :show, status: :ok, location: @friendship }
      else
        format.html { render :edit }
        format.json { render json: @friendship.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /friendships/1
  # DELETE /friendships/1.json
  def destroy
    @friendship.destroy
    respond_to do |format|
      format.html { redirect_to friendships_url, notice: 'Friendship was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_friendship
      @friendship = Friendship.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def friendship_params
      params.require(:friendship).permit(:user_id, :friend_id, :group_id)
    end
end

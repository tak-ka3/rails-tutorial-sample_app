class UsersController < ApplicationController
  # []ないのメソッドを実行する前にlogged_in_userを実行するという意味
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy

  def index
    @users = User.where(activated: true).paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
    # redirect_to root_url and return unless @user.activated?
  end
  def new
    @user = User.new
  end
  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:info] = "Please check your mail to activate your account."
      redirect_to root_url
    else
      render 'new'
    end
  end

  def edit
    # @user = User.find(params[:id])
  end

  def update
    # @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render "edit"
    end
  end

  def delete
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  private # これ以降はprivateメソッドであるので、このクラス内、つまりこのclassの書かれているコード内でしか呼び出せない
  def user_params
    params.require(:user).permit(:name, :email, :password, :password, :password_confirmation)
  end

  # beforeアクション

  # 正しいユーザーかどうかを確認
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user) # current_userはsession_helperで定義されている
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
end
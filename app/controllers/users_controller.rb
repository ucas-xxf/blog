class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy, :following, :followers]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy

  def new
    @user = User.new
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  def showuser
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  def show
      @user = User.find(params[:id])
      @microposts = @user.microposts.paginate(page: params[:page])
      if current_user.admin? && !current_user?(@user)
        User.find(@user.id).destroy
        redirect_to users_path
      end
    #debugger
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "欢迎来到ABLOG！"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "资料更新成功！"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "用户已删除！"
    redirect_to users_url
  end


  def following 
    @title = "关注列表"
    @user = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "粉丝"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
    end
  
    # def logged_in_user
    #   unless logged_in?
    #     store_location
    #     flash[:danger] = "Please log in."
    #     redirect_to login_url
    #   end
    # end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end

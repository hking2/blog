class UsersController < ApplicationController
  before_action :set_user, only: [
    :show, :edit, :update, :destroy
  ]
  before_action :require_user, except: [
    :show, :index
  ]
  before_action :require_owner, only: [
    :edit, :update, :destroy
  ]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Welcome to Alpha Blog. Sign up was successful."
      redirect_to articles_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "Profile Updated Successfully"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def show
    @articles = @user.articles
  end

  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end

  def destroy #delete
    @user.destroy
    session[:user_id] = nil if @user == current_user
    flash[:notice] = "Account and account data successfully deleted"
    redirect_to root_path
  end

  private
    def user_params
      #require top level key, then permit specific attributes
      params.require(:user).permit(:username, :email, :password)
    end

    def set_user
      @user = User.find(params[:id])
    end

    def require_owner
      if current_user != @user && !current_user.admin?
        flash[:alert] = "You are not the owner of this profile"
        redirect_to @user
      end
    end

end
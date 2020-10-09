class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "Welcome to Alpha Blog. Sign up was successful."
      redirect_to articles_path
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
      flash[:notice] = "Profile Updated Successfully"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def show
    @user = User.find(params[:id])
    @articles = @user.articles
  end

  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end

  private
    def user_params
      #require top level key, then permit specific attributes
      params.require(:user).permit(:username, :email, :password)
    end

end
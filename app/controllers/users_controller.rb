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

  private
    def user_params
      #require top level key, then permit specific attributes
      params.require(:user).permit(:username, :email, :password)
    end

end
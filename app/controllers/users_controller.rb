class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show, :edit, :update]
 
  def index
    @users = User.all
    @user = current_user
  end
  
  def show
    @book = Book.new 
    @user = User.find(params[:id])
    @books = @user.books
  end
  
  def edit
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_path(current_user.id)
    end
    @user = User.find(params[:id])
  end
  
  def update
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_path(current_user.id)
    end
    
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have created book successfully."
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end
  
  private

  def user_params
    params.require(:user).permit(:name, :email, :introduction, :profile_image)
  end
  
  
end

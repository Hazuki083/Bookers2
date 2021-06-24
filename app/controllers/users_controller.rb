class UsersController < ApplicationController
   def new
       @book = Book.new
   end

   def index
       @user = current_user
       @users = User.all
       @book = Book.new
       @books = Book.all
   end

   def show
       @user = User.find(params[:id])
       @books = @user.books.all
       @book = Book.new
   end

   def edit
       @user = User.find(params[:id])
   end

   def update
       @user =User.find(params[:id])
   end

 private

  def user_params
      params.require(:user).permit(:title, :profile_image, :introduction)
  end
end
class UsersController < ApplicationController
  before_action :authenticate_user!

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
       # bookmodelで定義したscope名
       @today_book = @books.created_today
       @yesterday_book = @books.created_yesterday
       @this_week_book = @books.created_this_week
       @last_week_book = @books.created_last_week
   end

   def edit
       @user = User.find(params[:id])
      if @user != current_user
        redirect_to user_path(current_user.id)
      end
   end

   def update
       @user = User.find(params[:id])
     if @user.update(user_params)
       flash[:notice] = "You have updated user successfully."
       redirect_to user_path(@user.id)
     else
       render :edit
     end
   end

   def follows
     user = User.find(params[:id])
     @users = user.followings
   end

   def followers
    user = User.find(params[:id])
    @users = user.followers
   end

 private

  def user_params
      params.require(:user).permit(:name, :profile_image, :introduction)
  end

end
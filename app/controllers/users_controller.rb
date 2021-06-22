class UsersController < ApplicationController
   def new
    @book = Book.new
   end

   def create

   end

   def index
    @user = current_user
    @book = Book.new
    @books = Book.all

   end

   def show
   end

   def edit
   end
end

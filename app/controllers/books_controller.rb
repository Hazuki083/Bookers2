class BooksController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    @book = Book.new
    @books = Book.all
    @books = Book.includes(:favorite_users).sort {|a,b| b.favorites_users.size <=> a.favorites_users.size}
  end
  
  def weekly_rank
    @ranks = Book.this_week 
  end
  
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
       flash[:notice] = "You have created book successfully."
       redirect_to book_path(@book)
    else
      @user =current_user
      @books =Book.all
      render :index
    end
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user_id != current_user.id
      redirect_to books_path
    else
       render :edit
    end
  end

  def show
    @newbook = Book.new
    @book = Book.find(params[:id])
    @user = @book.user
    @book_comment = BookComment.new
  end

  def update
       @book = Book.find(params[:id])
    if @book.update(book_params)
       flash[:notice] = "You have updated book successfully."
       redirect_to book_path(@book)
    else
       render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    if @book.destroy
      redirect_to books_path
    end
  end
  
  

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

end
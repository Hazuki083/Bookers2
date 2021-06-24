class BooksController < ApplicationController
  def index
    @user = current_user
    @book = Book.new
    @books = Book.all
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @book.save
    redirect_to book_path(@book.id)

  end

  def edit
    @book = Book.find(params[:id])
  end

  def show
    @user = current_user
    @book = Book.new
    @books = Book.find(params[:id])
  end

  def update
    book = Book.find(params[:id])
    book.update(book_params)
    if @book.update(book_params)
      redirect_to book_path(@book.id)
    else
      render :show
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
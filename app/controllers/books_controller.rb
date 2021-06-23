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
    @user = User.find(params[:id])
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
      flash[:notice]="Book was successfully updated."
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

end
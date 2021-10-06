class BooksController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    @book = Book.new
    @books = Book.all
    @ranks = Book.find(Favorite.group(:book_id).where(created_at: Time.current.all_week).order('count(book_id) desc').limit(10).pluck(:book_id))
    #groupで記事の番号(book_id)が同じものに分ける
    # time current で期間指定
    #'count(book_id) desc'で順位
    #pluck を入れることによりfavoriteモデルを探しに行くのを阻止

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
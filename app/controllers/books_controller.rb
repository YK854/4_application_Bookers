class BooksController < ApplicationController

  def index
    @books = Book.all.order(created_at: :desc)
    @book = Book.new
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      flash[:success] = 'Book was successfully created.'
      redirect_to "/books/#{@book.id}"
    else
      @books = Book.all.order(created_at: :desc)
      render :index
    end
  end

  def show
    @book = Book.find(params[:id])
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:success] = 'Book was successfully updated.'
      redirect_to "/books/#{@book.id}"
    else
      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    if book.destroy
      flash[:success] = 'Book was successfully destroyed.'
      redirect_to "/books"
    else
      redirect_to "/books"
    end
  end

  private
  def book_params
    params.require(:book).permit(:title, :body)
  end
end

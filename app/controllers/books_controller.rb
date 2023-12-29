class BooksController < ApplicationController
  
  def index
    @books = Book.all
    @book = Book.new
  end
  
  def create
    @book = Book.new(book_params)
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book)
    else
      @books = Book.all
      render :index
    end
  end
  
  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end
  
  private
  
  def book_params
    params.require(:book).permit(:title, :body)
  end

end

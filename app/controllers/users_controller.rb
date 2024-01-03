class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update]

  def index
    @users = User.page(params[:page])
    @user = current_user
    @book = Book.new
  end

  def show
    @user = User.find(params[:id])
    @book = Book.new
    @books = @user.books
      @today_book = @books.created_today
      @yesterday_book = @books.created_yesterday
      @this_week_book = @books.created_this_week
      @last_week_book = @books.created_last_week
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user)
      flash[:notice] = "You have updated user successfully."
    else
      render :edit
    end
  end
  
  def posts_on_date
    user = User.includes(:books).find(params[:user_id])
    date = Date.parse(params[:created_at])
    @books = user.books.where(created_at: date.all_day)
    render :posts_on_date_form
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_path(current_user)
    end
  end

end

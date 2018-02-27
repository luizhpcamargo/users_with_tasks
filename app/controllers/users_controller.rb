class UsersController < ApplicationController
  def index
    @user = User.new
    render :index
  end

  def signin
    @user = User.find_by(email: user_params[:email])
    if @user&.authenticate(user_params[:password])
      @tasks = @user.tasks
      session.clear
      session[:user_id] = @user.id
      render 'tasks/index'
    else
      flash[:alert] = 'Invalid email or password'
      @user = User.new
      render :index
    end
  end

  def signup
    @user = User.new
    render :signup
  end

  def create
    @user = User.new(user_params)

    if @user.save
      @tasks = @user.tasks
      render 'tasks/index'
    else
      render :signup
    end
  end

  protected

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end

class UsersController < ApplicationController
  def index
    render :index
  end

  def signin
    user = User.find_by(email: user_params[:email])
    if user&.authenticate(user_params[:password])
      session.clear
      session[:user_id] = user.id
      render :logged
    else
      render :index, alert: 'Invalid email or password'
    end
  end

  def signup
    render :signup
  end

  def create
    user = User.new(user_params)

    if user.save
      render :logged
    else
      render :signup
    end
  end

  protected

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end

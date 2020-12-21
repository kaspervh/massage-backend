class AutheticationController < ApplicationController
  def login
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      render json: {
        status: 200,
        user: user,
      }
    else
      render json: {status: 401}
    end
  end

  def auto_login
    render json: @user
  end
end

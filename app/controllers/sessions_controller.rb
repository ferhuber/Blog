class SessionsController < ApplicationController
# after_action(:find_user )
  def new

  end

  def create
    user = User.find_by_email params[:email]
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: 'Signed in!'
    else
      flash.now[:alert] = 'Wrong credentials!!!'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: 'Signed out!'
  end

  def edit

    session = session[:user_id]
    @user = User.find params[session.user_id]
  end


end

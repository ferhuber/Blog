class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def user_params
    user_params = params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :is_admin)
  end

  def create

    @user = User.new user_params  # User.new { first_name: 'alex', .. }
    if @user.save
      session[:user_id] = @user.id
      # login the user
      redirect_to root_path, notice: 'Account created successfully!'
    else
      render :new
    end
  end

  def show
    @user = User.find session[:user_id]
    @users = User.all
    @posts_count = Post.count
    @comments_count   = Comment.count
    @user_count     = User.count
  end

  def edit
    @user = User.find params[:id]
  end

  def update
    @user = User.find params[:id]
      if @user.update user_params
        redirect_to user_path(current_user.id)
      else
        render :edit
      end
  end

  def destroy
    user = User.find params[:id]
    user.destroy
    redirect_to user_path
  end

end

class Admin::DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize

  def index
    @posts_count = Post.count
    @comments_count   = Comment.count
    @user_count     = User.count
  end


  private

    def authorize
      head :unauthorized unless current_user.is_admin?
    end
  end

end

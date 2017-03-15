class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_like, only: [:destroy]
  before_action :find_post, only: [:create]



  def index
    @user = current_user
    @posts = @user.liked_posts
  end

  def create
    if cannot? :like, @post
      redirect_to post_path(@post), alert: 'Liking your own Product isn\'t allowed'

      return
    end

    like = Like.new(user: current_user, post: @post)

    if like.save
      redirect_to post_path(@post)
    else
      redirect_to post_path(@post), alert: 'Couldn\'t like post! '
    end
  end


  def destroy
    if cannot? :like, @like.post
      redirect_to post_path(@like.post), alert: 'Un-liking your own Product isn\'t allowed'
      return
    end

    redirect_to(
      post_path(@like.post),
      @like.destroy ? {} : {alert: @like.errors.full_messages.join(', ')}
    )
  end



  private
  def find_like
    @like ||= Like.find(params[:id])
  end

  def find_post
    @post ||= Post.find(params[:post_id])
  end
end

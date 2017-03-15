class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  before_action(:find_post, { except: [:create, :new, :index] })


  before_action :authorize, only: [:edit, :destroy, :update]

  def new
    @post  = Post.new

  end

  def create
    post_params = params.require(:post).permit([:id, :title, :post, :category_id])
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save

      redirect_to posts_path(@post)
    else
      render :new
    end
  end

  def index
    @posts = Post.order(created_at: :desc)
  end

  def show
    @post = Post.find params[:id]
    @comment = Comment.new
    @comments = Comment.where(post_id: @post.id)
    @user = @post.user
    @category = Category.find(@post.category_id)
  end

  def destroy
    post = Post.find params[:id]
    post.destroy
    redirect_to posts_path
  end

  def edit
  end

  def update
    @post = Post.find params[:id]

    post_params = params.require(:post).permit([:id, :title, :post, :category_id])

    if @post.update post_params
      redirect_to post_path(@post), notice: 'Post updated!'
    else
      render :edit
    end
  end

  def destroy
      post = Post.find params[:id]
      post.destroy
      redirect_to posts_path
  end

  def liked_by?(user)
    likes.exists?(user: user)
  end

  def like_for(user)
    likes.find_by(user: user)
  end




  private

  def find_post
    @post = Post.find(params[:id])
  end

  def find_comment
    @comment = Comment.find params[:id]
  end

  def authorize
    if cannot?(:manage, @post)
      redirect_to root_path, alert: 'Not authorized!'
    end
  end

end

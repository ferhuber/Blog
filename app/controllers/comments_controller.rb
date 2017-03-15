class CommentsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  before_action(:find_comment, { only: [:edit, :destroy, :update] })
  before_action(:find_post, { only: [:create, :destroy] })
  before_action :authorize, only: [:edit, :destroy, :update]

  def create
      @comment = Comment.new(comment_params)
      @comment.user = current_user
      @comment.post = @post

      if (@comment.save)
        CommentsMailer.notify_post_owner(@comment).deliver_later #deliver_now
        redirect_to post_path(@post), notice: 'Comment submitted'
      else
        flash.now[:alert] = 'Please fix errors below'
        render 'posts/show'
     end
  end

  def destroy

    comment = Comment.find params[:id]
    comment.destroy
    redirect_to post_path(comment.post_id), notice: 'Comment was deleted!'

  end

  def edit
  end

  def update
    if @comment.update comment_params
      redirect_to post_path(@comment.post), notice: 'Comment updated!'
    else
      render :edit
    end
  end

  private
    def comment_params
      params.require(:comment).permit([:title, :body])
    end

    def find_comment
      @comment = Comment.find params[:id]
    end

    def find_post
      @post = Post.find(params[:post_id])
    end

    def authorize
      if cannot?(:manage, @comment)
        redirect_to root_path, alert: 'Not authorized!'
      end
    end

end

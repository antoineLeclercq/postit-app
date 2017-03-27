class CommentsController < ApplicationController
  before_action :require_user

  def create
    @comment = @post.comments.build(params_comment)
    @comment.creator = current_user

    if @comment.save
      flash[:notice] = 'Your comment was added.'
      redirect_to post_path(@post)
    else
      render 'posts/show'
    end
  end

  def vote
    @comment = Comment.find(params[:id])
    vote = Vote.create(vote: params[:vote], voteable: @comment, creator: current_user)

    if vote.valid?
      flash[:notice] = 'Your vote was counted.'
    else
      flash[:error] = 'You can only vote once on this comment.'
    end

    redirect_to :back
  end

  private

  def params_comment
    params.require(:comment).permit(:body)
  end
end
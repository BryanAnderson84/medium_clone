class CommentsController < ApplicationController
  before_action :comment, except: [:index, :new, :create]
  before_action :post

  def index
    @comments = @post.comments
  end

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment[:post_id] = params[:post_id]
    if @comment.save
      redirect_to post_path(@post)
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @comment.update(comment_params)
    redirect_to post_comment_path(@post)
    else
    render :edit
    end
  end

  def destroy
    @comment.destroy
    redirect_to post_path(@post)
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def comment
    @comment = Comment.find(params[:id])
  end

  def post
    @post = Post.find(params[:post_id])
  end
end

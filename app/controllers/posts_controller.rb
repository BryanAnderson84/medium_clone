class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :post, except: [:index, :new, :create]
  before_action :authorized_user, only: [:edit, :update, :destroy]

  def index
    @posts = Post.all.paginate(page: params[:page], per_page: 8).order(created_at: :desc)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post[:user_id] = current_user.id
    if @post.save
      redirect_to posts_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    @post.update(post_params)
    redirect_to post_path(@post)
  end

  def destroy
    @post.destroy
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :user_id)
  end

  def post
    @post = Post.find(params[:id])
  end

  def authorized_user
    @post = current_user.posts.find_by(id: params[:id])
    redirect_to posts_path, notice: "You are not authorized, son" if @post.nil?
  end

end

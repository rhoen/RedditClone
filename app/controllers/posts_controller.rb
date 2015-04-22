class PostsController < ApplicationController
  def new
    @subs = Sub.all
    @default_sub_id = params[:sub_id].to_i
    @post = Post.new
    render :new
  end

  def create
    @post = Post.new(post_params)
    @post.author_id = current_user.id
    @subs = Sub.all
    if @post.save
      @post.sub_ids = params[:post][:sub_ids]

      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def destroy
    redirect_to sub_url(@post.sub)
    current_post.destroy
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @subs = Sub.all
    current_post
    render :edit
  end

  def update
    if current_post.update(post_params)
      current_post.sub_ids = params[:post][:sub_ids]
      redirect_to post_url(current_post)
    else
      flash.now[:errors] = current_post.errors.full_messages
      render :edit
    end
  end

  private

  def post_params
    params.require(:post).permit(:sub_id, :title, :content, :url)
  end

  def current_post
    @post ||= Post.find(params[:id])
  end
end

class PostsController < ApplicationController
  def new
    @subs = Sub.all
    @default_sub = params[:sub_id]
    @post = Post.new
    render :new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      params[:post][:sub_ids].each do |sub_id|
        PostSub.create!(sub_id: sub_id, post_id: @post.id)
      end

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
      redirect_to sub_url(current_post.sub)
    else
      flash.now[:errors] = current_post.errors.full_messages
      render :edit
    end
  end

  private

  def post_params
    params.require(:post).permit(:author_id, :sub_id, :title, :content, :url)
  end

  def current_post
    @post ||= Post.find(params[:id])
  end
end

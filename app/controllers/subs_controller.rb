class SubsController < ApplicationController
  before_action :ensure_moderator, only: [:update, :edit, :destroy]
  def new
    @sub = Sub.new
    render :new
  end

  def create
    @sub = Sub.new(sub_params)
    if @sub.save
      redirect_to sub_url @sub
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def show
    current_sub
    render :show
  end

  def destroy
    current_sub.destroy
    redirect_to subs_url
  end

  def index
    @subs = Sub.all
    render :index
  end

  def edit
    current_sub
    render :edit
  end

  def update
    if current_sub.update(sub_params)
      redirect_to sub_url(current_sub)
    else
      flash.now[:errors] = current_sub.errors.full_messages
      render :edit
    end
  end

  private
  def sub_params
    params.require(:sub).permit(:title, :description, :moderator_id)
  end
  def current_sub
    @sub ||= Sub.find(params[:id])
  end
  def ensure_moderator
    unless current_user.id == current_sub.moderator_id
      redirect_to sub_url current_sub
    end
  end

end

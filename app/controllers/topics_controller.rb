class TopicsController < ApplicationController
  before_filter :signed_in_user, only: [:index, :edit, :update]
  before_filter :admin_user,     only: :destroy
  
  def show
    @topic = Topic.find(params[:id])
    @posts = @topic.posts.paginate(page: params[:page])
    @post = @topic.posts.build if signed_in?
  end
  
  def edit
    @topic = Topic.find(params[:id])
  end
  
  def update
    @topic = Topic.find(params[:id])
    if @topic.update_attributes(params[:topic])
      flash[:success] = "Topic updated"
      redirect_to @topic
    else
      render 'edit'
    end
  end

  def index
    @topics = Topic.paginate(page: params[:page]).order('updated_at ASC')
  end

  def destroy
    Topic.find(params[:id]).destroy
    flash[:success] = "Topic destroyed."
    redirect_to topics_url
  end

  def reply
    @topic = Topic.find(params[:id])
    @post = @topic.posts.build(params[:post])
    @post.user_id = current_user

    if params[:preview] || !@post.save
      render 'reply'
    else
      flash[:success] = "Posted"
      redirect_to topic_path(@topic)
    end
  end
end

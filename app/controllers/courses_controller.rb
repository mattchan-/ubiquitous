class CoursesController < ApplicationController
  before_filter :signed_in_user, except: :index
  before_filter :admin_user,     except: [:index, :add_topic]
  
  def show
    @course = Course.find(params[:id])
    @topics = @course.topics.paginate(page: params[:page]).order('updated_at ASC')
    @topic = Course.new
  end
  
  def new
    @course = Course.new
  end
  
  def create
    @course = Course.new(params[:course])
    if @course.save
      flash[:success] = "Added " + @course.name
      redirect_to @college_id.college_url
    else
      render 'new'
    end
  end
  
  def edit
    @course = Course.find(params[:id])
  end
  
  def update
    @course = Course.find(params[:id])
    if @course.update_attributes(params[:course])
      flash[:success] = "course updated"
      redirect_to @college_id.college_url
    else
      render 'edit'
    end
  end

  def index
    @courses = Course.paginate(page: params[:page]).order('name ASC')
  end

  def destroy
    @course = Course.find(params[:id])
    @college = @course.college

    @course.destroy
    flash[:success] = "course destroyed."
    redirect_to college_url(@college)
  end

  def add_topic
    @course = Course.find(params[:id])
    @topic = @course.topics.build(params[:topic])
    @topic.course_id = @course.id
  end

  def save_topic
    @course = Course.find(params[:id])
    @topic = @course.topics.build(params[:topic])

    @post = @topic.posts.build(params[:post])
    @post.user_id = current_user
    if @topic.save
      flash[:success] = "Added " + @topic.name
      redirect_to topic_path(@topic)
    else
      render 'new'
    end
  end
end

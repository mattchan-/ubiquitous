class CollegesController < ApplicationController
  before_filter :signed_in_user, except: :index
  before_filter :admin_user,     except: :index

  def show
    @college = College.find(params[:id])
  end

  def new
    @college = College.new
  end

  def create
    @college = College.new(params[:college])
    if @college.save
      flash[:success] = "Added " + @college.name
      redirect_to @college
    else
      render 'new'
    end
  end

  def edit
    @college = College.find(params[:id])
  end

  def update
    @college = College.find(params[:id])
    if @college.update_attributes(params[:college])
      flash[:success] = "College updated"
      redirect_to @college
    else
      render 'edit'
    end
  end

  def index
    @colleges = College.paginate(page: params[:page]).order('name ASC')
  end

  def destroy
    College.find(params[:id]).destroy
    flash[:success] = "College destroyed."
    redirect_to colleges_url
  end
end

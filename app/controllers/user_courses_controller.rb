class UserCoursesController < ApplicationController
  def create
    @user_course = UserCourse.new
    @user_course.user_id = current_user.id
    @user_course.course_id = params[:course_id]
    @user_course.save
    redirect_to user_url(current_user)
  end

  def destroy
  end
end

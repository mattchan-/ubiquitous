# == Schema Information
#
# Table name: user_courses
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  course_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class UserCourse < ActiveRecord::Base
  attr_accessible :user_id, :course_id
  belongs_to :user
  belongs_to :course

  validates :user_id, uniqueness: { scope: :course_id }
end

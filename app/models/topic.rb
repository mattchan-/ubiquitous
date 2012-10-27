# == Schema Information
#
# Table name: topics
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  course_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Topic < ActiveRecord::Base
	attr_accessible :name, :course_id
	belongs_to :course
	has_many :posts

	validates :name, presence: true

  accepts_nested_attributes_for :posts
end

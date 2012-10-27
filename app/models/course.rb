# == Schema Information
#
# Table name: courses
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  college_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Course < ActiveRecord::Base
	attr_accessible :name, :college_id
	belongs_to :college
	has_many :users
	has_many :topics

	validates :name, presence: true, uniqueness: { case_sensitive: false }
end

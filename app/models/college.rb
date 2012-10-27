# == Schema Information
#
# Table name: colleges
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class College < ActiveRecord::Base
	attr_accessible :name
	has_many :users
	has_many :courses

	validates :name, presence: true, uniqueness: { case_sensitive: false }
end

# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  content    :text
#  topic_id   :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Post < ActiveRecord::Base
	attr_accessible :content, :topic_id
	belongs_to :topic
	belongs_to :user

	validates :content, presence: true
  validates :user_id, presence: true

	default_scope order: "created_at ASC"
end

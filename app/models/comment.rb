class Comment < ApplicationRecord
  belongs_to :recipe
  belongs_to :user
  belongs_to :parent_comment, class_name: "Comment", optional: true
  has_many :replies, class_name: "Comment", foreign_key: "parent_comment_id", dependent: :destroy
end

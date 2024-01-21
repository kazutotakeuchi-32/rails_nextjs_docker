class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :article
  has_many :likes, dependent: :destroy, class_name: "CommentLike", foreign_key: :comment_id

end

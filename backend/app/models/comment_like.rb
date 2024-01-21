class CommentLike < ApplicationRecord
  belongs_to :comment
  belongs_to :user
  self.inheritance_column = :_type_disabled 

  enum status: { good_like: 1, bad_like: 2 }



end

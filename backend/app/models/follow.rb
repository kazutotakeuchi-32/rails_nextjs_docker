class Follow < ApplicationRecord
  belongs_to :user
  belongs_to :follow, class_name: "User", foreign_key: :target_user_id
end

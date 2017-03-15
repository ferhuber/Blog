class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user

  scope :latest_first, -> {order("created_at DESC")}

end

class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :event

  validates :content, presence: true, length: { maximum: 250 }
end

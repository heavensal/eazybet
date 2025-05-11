class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :event, touch: true

  validates :content, presence: true, length: { maximum: 250 }
end

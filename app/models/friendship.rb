class Friendship < ApplicationRecord
  belongs_to :sender, class_name: "User"
  belongs_to :receiver, class_name: "User"

  validates :status, presence: true, inclusion: { in: %w[pending accepted declined] }
  validates :sender, uniqueness: { scope: :receiver }
  validate :cannot_be_friend_with_self

  def cannot_be_friend_with_self
    errors.add(:sender, "cannot be friend with self") if sender == receiver
  end
end

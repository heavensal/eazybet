class Ad < ApplicationRecord
  mount_uploader :video, VideoUploader

  validates :video, presence: true
  validates :title, presence: true
  validates :active, inclusion: { in: [ true, false ] }
  validates :views_count, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :description, length: { maximum: 500 }

  scope :active, -> { where(active: true) }
end

# create_table "ads", force: :cascade do |t|
#   t.string "title", null: false
#   t.text "description"
#   t.string "video"
#   t.boolean "active", default: false, null: false
#   t.integer "views_count", default: 0
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false
# end

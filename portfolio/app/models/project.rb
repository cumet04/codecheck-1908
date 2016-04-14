class Project < ActiveRecord::Base
  belongs_to :thumb
  validates :title, presence: true, length: { maximum: 255 }
  validates :description, presence: true
  validates :url, length: { maximum: 255 }
  validates :thumb_id, presence: true
end

class Project < ActiveRecord::Base
  validates :title, presence: true, length: { maximum: 255 }
  validates :description, presence: true
  validates :url, length: { maximum: 255 }
end

class Thumb < ActiveRecord::Base
  has_one :project
  validates :file, presence: true
end

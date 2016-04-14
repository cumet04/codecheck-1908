class Thumb < ActiveRecord::Base
  validates :file, presence: true
end

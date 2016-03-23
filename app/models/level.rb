class Level < ActiveRecord::Base
  belongs_to :user
  has_many :grades
end

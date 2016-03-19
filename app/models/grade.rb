class Grade < ActiveRecord::Base
  belongs_to :student
  belongs_to :user
  has_many :markpercents
  has_many :subjects, through: :markpercents
end

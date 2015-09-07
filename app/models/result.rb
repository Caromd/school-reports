class Result < ActiveRecord::Base
  belongs_to :student
  belongs_to :subject
  belongs_to :term
  validates :classmark, presence: true
  validates :testmark, presence: true
  validates_presence_of :student
  validates_presence_of :subject
  validates_presence_of :term
end

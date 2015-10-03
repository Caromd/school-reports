class Result < ActiveRecord::Base
  belongs_to :report
  belongs_to :subject
  validates :classmark, presence: true
  validates :testmark, presence: true
  validates_presence_of :report
  validates_presence_of :subject
end

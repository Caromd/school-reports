class Report < ActiveRecord::Base
  belongs_to :student
  belongs_to :term
  has_many :results
end
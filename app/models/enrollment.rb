class Enrollment < ActiveRecord::Base
  belongs_to :student
  belongs_to :subject
  belongs_to :schoolyear
end

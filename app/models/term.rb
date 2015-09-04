class Term < ActiveRecord::Base
  belongs_to :schoolyear
  has_many :results
end

class Result < ActiveRecord::Base
  belongs_to :enrollment
  belongs_to :term
end

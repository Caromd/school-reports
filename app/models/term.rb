class Term < ActiveRecord::Base
    has_many :results
    validates :year, presence: true
    validates :term, presence: true
    validates :startdate, presence: true
    validates :enddate, presence: true
end

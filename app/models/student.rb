class Student < ActiveRecord::Base
    has_many :results
    has_many :grades
    validates :firstname, presence: true
    validates :surname, presence: true
    def to_label
        "#{firstname}"
    end
end

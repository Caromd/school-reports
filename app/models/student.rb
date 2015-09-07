class Student < ActiveRecord::Base
    has_many :enrollments
    validates :firstname, presence: true
    validates :surname, presence: true
    def to_label
        "#{firstname}"
    end
end

class Student < ActiveRecord::Base
    has_many :enrollments
    
    def to_label
        "#{firstname}"
    end
end

class Schoolyear < ActiveRecord::Base
    has_many :enrollments
    has_many :terms
    
    def to_label
        "#{year}"
    end
end

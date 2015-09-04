class Schoolyear < ActiveRecord::Base
    has_many :enrollments
    has_many :terms
end

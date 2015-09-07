class Subject < ActiveRecord::Base
    has_many :enrollments
    validates :name, presence: true
end

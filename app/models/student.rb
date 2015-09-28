class Student < ActiveRecord::Base
    has_many :results
    has_many :grades
    accepts_nested_attributes_for :grades, reject_if: :all_blank, allow_destroy: true
    validates :firstname, presence: true
    validates :surname, presence: true
    def to_label
        "#{firstname}"
    end
end

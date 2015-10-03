class Student < ActiveRecord::Base
    has_many :grades
    has_many :reports
    accepts_nested_attributes_for :grades, reject_if: :all_blank, allow_destroy: true
    validates :firstname, presence: true
    validates :surname, presence: true
    def to_label
        "#{firstname} #{surname}"
    end
end

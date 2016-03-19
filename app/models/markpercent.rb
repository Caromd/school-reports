class Markpercent < ActiveRecord::Base
    belongs_to :grade
    belongs_to :subject
    belongs_to :user
    accepts_nested_attributes_for :grade, reject_if: :all_blank, allow_destroy: true
    accepts_nested_attributes_for :subject, reject_if: :all_blank, allow_destroy: true
end

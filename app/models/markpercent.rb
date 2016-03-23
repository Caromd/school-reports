class Markpercent < ActiveRecord::Base
    belongs_to :level
    belongs_to :subject
    belongs_to :user
    validates :level_id, presence: true
    validates :subject_id, presence: true
end

class Subject < ActiveRecord::Base
    has_many :results
    belongs_to :user
    has_many :markpercents
    has_many :grades, through: :markpercents
    validates :name, presence: true
end

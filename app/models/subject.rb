class Subject < ActiveRecord::Base
    has_many :results
    belongs_to :user
    validates :name, presence: true
end

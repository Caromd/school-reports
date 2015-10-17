class Term < ActiveRecord::Base
    has_many :reports
    belongs_to :user
    validates :year, presence: true
    validates :term, presence: true
    def to_label
        "#{year} #{term}"
    end
end

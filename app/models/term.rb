class Term < ActiveRecord::Base
    has_many :results
    validates :year, presence: true
    validates :term, presence: true
    def to_label
        "#{year} #{term}"
    end
end

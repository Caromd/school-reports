class Report < ActiveRecord::Base
  belongs_to :student
  belongs_to :term
  belongs_to :user
  has_many :results, :dependent => :destroy
  accepts_nested_attributes_for :results, reject_if: :all_blank, allow_destroy: true
  def to_label
    student = Student.find_by id: self.student_id
    term = Term.find_by id: self.term_id
    "#{student.firstname} #{student.surname} #{term.year} #{term.term}"
  end
end

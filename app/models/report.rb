class Report < ActiveRecord::Base
  belongs_to :student
  belongs_to :term
  has_many :results
  def to_label
    student = Student.find_by id: self.student_id
    term = Term.find_by id: self.term_id
    "#{student.firstname} #{student.surname} #{term.year} #{term.term}"
  end
end

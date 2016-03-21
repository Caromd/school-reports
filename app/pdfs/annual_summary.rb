class AnnualSummary < Prawn::Document
  def initialize
    super({:page_size => 'A4', :page_layout => :landscape})
    @terms = Term.where(year: '2016')
    @grade = Grade.find_by(name: '12', year: '2016')
    @grades = Grade.where(name: '12', year: '2016')
#    @students = Student.where(id: @grade.student_id)
#    @reports = Report.where(student_id: @students.id, term_id: @terms.id)
#    @results = Result.where(report_id: @reports.id)
#    @subjects = Subject.where(id: @results.subject_id)
    
#    @student = Student.find(report.student_id)
#    @term = Term.find(report.term_id)
#    @next_term = Term.where("startdate > ?", @term.startdate).order("startdate ASC").first
#    @results = Result.where(report_id: @reports.id)
#    @average_class = Result.where(report_id: report.id).average(:classmark).round
#    @average_test = Result.where(report_id: report.id).average(:testmark).round
#    @grade = Grade.find_by(student_id: report.student_id, year: @term.year)
#    @grand_total = 0
#    @number_of_subjects = 0
    @user = User.find(1)

#    school_header
#    subject_header
#    term_header
#    table_content
write_data
  end

def write_data
  text "GRADE " + @grade.name
  @grades.map do |g|
    text "STUDENT ID " + g.student_id.to_s
    @student = Student.find_by_id(g.student_id)
    text "STUDENT NAME " + @student.firstname
    @terms.map do |t|
      text "TERM...." + t.term
      @report = Report.find_by(student_id: g.student_id, term: t.term)
      text "REPORT......" + @report.id.to_s
      @results = Result.where(report_id: @report.id)
      @results.map do |r|
        @subject = Subject.find_by_id(r.subject_id)
        text "RESULTS.........." + r.classmark.to_s + ' ' + @subject.name
      end
    end
  end
end


  ## SCHOOL NAME
  ## GRADE NAME
  def school_header
    y_position = cursor - 30
    bounding_box([0, y_position], :width => 290, :height => 50) do
      text @user.schoolname, size: 25, style: :bold, align: :center
    end
    y_position = cursor - 5
    bounding_box([0, y_position], :width => 200, :height => 110) do
      text "GRADE " + @grade.name, size: 20, style: :bold, align: :center
    end
  end

  def subject_header
    @subjects.map do |s|
      y_position = cursor - 5
      bounding_box([0, y_position], :width => 200, :height => 110) do
        text s.name, size: 20, style: :bold, align: :center
      end
      term_header
    end
  end

  def term_header
    @terms_header = ""
    @terms.map do |t|
      @terms_header = @terms_header || t.name || ','
    end
    ["TERM1","TERM2","TERM3","TERM4"]
  end
  
  def item_header
    ["PRAC","THEORY","PRAC","THEORY","PRAC","THEORY","PRAC","THEORY",]
  end

  def item_rows
    @results.map do |r|
      @report = Report.find(r.report_id)
      @student = Student.find(@report.student_id)
      [@student.firstname, 
      r.classmark.round, 
      r.testmark.round]
    end
  end
  
  def item_average
#    @average_total = @grand_total / @number_of_subjects
#    ["Average", "",@average_class, "", @average_test, @average_total.round, ""]
[0,0,0,0,0,0,0]
  end

  def item_table_data
    [term_header, item_header, *item_rows, item_average] 
  end

  def table_content
    table(item_table_data) do
      row(0).font_style = :bold
      self.row_colors = ["DDDDDD", "FFFFFF"]
      self.header = true
      self.cell_style = { size: 9 }
      self.column_widths = [100,100,50,100,50,50,250]
    end
  end
end
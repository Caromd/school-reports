class AnnualSummary < Prawn::Document
  def initialize
    super({:page_size => 'A4', :page_layout => :landscape})
    @terms = Term.where(year: '2016')
    @level = Level.find_by(name: '12')
    @grades = Grade.where(level_id: @level.id, year: '2016')
    @markpercents = Markpercent.where(level_id: @level.id)
    
    @term1_classmark = "0";
    @term1_testmark = "0";
    @term2_classmark = "0";
    @term2_testmark = "0";
    @term3_classmark = "0";
    @term3_testmark = "0";
    @term4_classmark = "0";
    @term4_testmark = "0";
    
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

school_header
#    subject_header
    term_table_content
#    item_rows
    table_content
  end

def school_header
  text @user.schoolname, size: 25, style: :bold, align: :center
  text "GRADE " + @level.name, size: 20, style: :bold, align: :center
end

def item_rows
  @markpercents.map do |m|
    @subject = Subject.find_by_id(m.subject_id)
    text "SUBJECT " + @subject.name

    @grades.map do |g|
      @student = Student.find_by_id(g.student_id)
      @student_name = @student.firstname + " " + @student.surname
      @terms.map do |t|
        @report = Report.find_by(student_id: g.student_id, term_id: t.id)
        @results = Result.where(report_id: @report.id, subject_id: m.subject_id)
        @results.map do |r|
          case t.term
          when "1"
            @term1_classmark = r.classmark.to_s.strip;
            @term1_testmark = r.testmark.to_s.strip;
          when "2"
            @term2_classmark = r.classmark.to_s.strip;
            @term2_testmark = r.testmark.to_s.strip;
          when "3"
            @term3_classmark = r.classmark.to_s;
            @term3_testmark = r.testmark.to_s;
          when "4"
            @term4_classmark = r.classmark.to_s;
            @term4_testmark = r.testmark.to_s;
          end
#          text "RESULTS.........." + r.classmark.to_s + ' ' + @subject.name
        end
      end
    end
#      text @student_name +  " "  + @term1_classmark +  " "  + @term1_testmark +  " "  + @term2_classmark +  " "  + @term2_testmark +  " "  + @term3_classmark +  " "  + @term3_testmark +  " "  + @term4_classmark +  " "  + @term4_testmark
      [@student_name,@term1_classmark,@term1_testmark,@term2_classmark,@term2_testmark,@term3_classmark,@term3_testmark,@term4_classmark,@term4_testmark]
  end
end


  ## SCHOOL NAME
  ## GRADE NAME
#  def school_header
#    y_position = cursor - 30
#    bounding_box([0, y_position], :width => 290, :height => 50) do
#      text @user.schoolname, size: 25, style: :bold, align: :center
#    end
#    y_position = cursor - 5
#    bounding_box([0, y_position], :width => 200, :height => 110) do
#      text "GRADE " + @grade.name, size: 20, style: :bold, align: :center
#    end
#  end

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
    ["","TERM1","TERM2","TERM3","TERM4"]
  end
  
  def item_header
    ["PRAC","THEORY","PRAC","THEORY","PRAC","THEORY","PRAC","THEORY",]
  end

#  def item_rows
#    @results.map do |r|
#      @report = Report.find(r.report_id)
#      @student = Student.find(@report.student_id)
#      [@student.firstname, 
#      r.classmark.round, 
#      r.testmark.round]
#    end
#  end
  
  def item_average
#    @average_total = @grand_total / @number_of_subjects
#    ["Average", "",@average_class, "", @average_test, @average_total.round, ""]
[0,0,0,0,0,0,0]
  end

  def term_table_data
    [term_header] 
  end

  def term_table_content
    table(term_table_data) do
      row(0).font_style = :bold
      self.row_colors = ["DDDDDD", "FFFFFF"]
      self.header = true
      self.cell_style = { size: 9 }
      self.column_widths = [100,100,100,100,100]
    end
  end

  def item_table_data
#    [item_header, *item_rows] 
[*item_rows]
  end

  def table_content
    table(item_table_data) do
      row(0).font_style = :bold
      self.row_colors = ["DDDDDD", "FFFFFF"]
      self.header = true
      self.cell_style = { size: 9 }
      self.column_widths = [100,50,50,50,50,50,50,50,50]
    end
  end
end
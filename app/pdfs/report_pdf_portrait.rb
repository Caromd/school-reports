class ReportPdfPortrait < Prawn::Document
  def initialize(report)
    super({:page_size => 'A4'})
    @report = Report.find(report.id)
    @student = Student.find(report.student_id)
    @term = Term.find(report.term_id)
    @next_term = Term.where("startdate > ?", @term.startdate).order("startdate ASC").first
    @results = Result.where(report_id: report.id)
    @average_class = Result.where(report_id: report.id).average(:classmark).round
    @average_test = Result.where(report_id: report.id).average(:testmark).round
    @grade = Grade.find_by(student_id: report.student_id, year: @term.year)
    @grand_total = 0
    @number_of_subjects = 0
    @user = User.find(report.user_id)

    header
    text_content
    move_down 10
    table_content
    teacher_comment_box
    principal_comment_box
    
  end

  def header
    y_position = cursor - 30
    bounding_box([0, y_position], :width => 200, :height => 110) do
      image "#{Rails.root}/app/assets/images/MARKSLOGO.png", width: 192, height: 105
    end
    bounding_box([210, y_position], :width => 290, :height => 110) do
      move_down 30
      text @user.schoolname, size: 25, style: :bold, align: :left
    end
  end

  def text_content
    # The cursor for inserting content starts on the top left of the page. 
    # Here we move it down a little to create more space between the text and the image inserted above
    y_position = cursor - 10

    # The bounding_box takes the x and y coordinates for positioning its content and some options to style it
    bounding_box([0, y_position], :width => 500, :height => 100) do
      move_down 10
      text "TERM " + @term.term + " " + @term.year, size: 20, style: :bold, align: :center
      text "GRADE " + @grade.name, size: 20, style: :bold, align: :center
      text @student.firstname + " " + @student.surname, size: 25, style: :bold, align: :center
      move_down 10
      stroke do
        line bounds.top_left, bounds.top_right
        line bounds.bottom_left, bounds.bottom_right
      end
    end
  end

  def item_header
    ["Subject", "Mark 1", "Mark 2", "Total", "Comment"]
  end

  def item_rows
    @results.map do |r|
      @subject = Subject.find(r.subject_id)
#      subject_total = (r.classmark * @subject.mark1_percentage / 100) + (r.testmark * @subject.mark2_percentage / 100)
    subject_total = (r.classmark * 25 / 100) + (r.testmark * 75 / 100)
      @grand_total = @grand_total + subject_total
      @number_of_subjects = @number_of_subjects + 1
      [@subject.name, r.classmark.round, r.testmark.round, subject_total.round, r.comment]
    end
  end
  
  def item_average
    @average_total = @grand_total / @number_of_subjects
    ["Average", @average_class, @average_test, @average_total.round, ""]
  end

  def item_table_data
    [item_header, *item_rows, item_average] 
  end

  def table_content
    table(item_table_data) do
      row(0).font_style = :bold
      self.row_colors = ["DDDDDD", "FFFFFF"]
      self.header = true
      self.cell_style = { size: 9 }
      self.column_widths = [100,50,50,50,250]
    end
  end

  def teacher_comment_box
    y_position = cursor - 20
    bounding_box([0, y_position], :width => 500, :height => 100) do
      text @report.teacher_comment, size: 12
      move_down 10
      text @report.teacher + " (Class Teacher)", size: 12, style: :italic
    end
  end
  
  def principal_comment_box
    y_position = cursor - 10
    bounding_box([0, y_position], :width => 500, :height => 100) do
      text @report.principal_comment, size: 12
      move_down 10
      text "School reopens on " + @next_term.startdate.strftime("%A, #{@next_term.startdate.day.ordinalize} %B %Y") + ".", size: 12
      move_down 10
      text "Yours faithfully", size: 12
      move_down 10
      text @report.principal + " (Principal)", size: 12, style: :italic
    end
  end
end
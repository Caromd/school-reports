class ReportPdf < Prawn::Document
  def initialize(report)
    super()
    @report = Report.find(1)
#    @student = Student.find(@report.student_id)
#    @term = Term.find(@report.term_id)
#    @results = Result.find(@report.report_id)
    @student = Student.find(1)
    @term = Term.find(1)
    @results = Result.all
    @grade = Grade.find(1)

    header
    text_content
    move_down 10
    table_content
    teacher_comment_box
    principal_comment_box
    
  end

  def header
    #This inserts an image in the pdf file and sets the size of the image
    image "#{Rails.root}/app/assets/images/1000hillsbanner.jpg", width: 500, height: 105
  end

  def text_content
    # The cursor for inserting content starts on the top left of the page. 
    # Here we move it down a little to create more space between the text and the image inserted above
    y_position = cursor - 40

    # The bounding_box takes the x and y coordinates for positioning its content and some options to style it
    bounding_box([0, y_position], :width => 500, :height => 100) do
      move_down 10
      text "TERM " + @term.term + " " + @term.year, size: 20, style: :bold, align: :center
      text "GRADE " + @grade.grade, size: 20, style: :bold, align: :center
      text @student.firstname + " " + @student.surname, size: 25, style: :bold, align: :center
      move_down 10
      stroke do
        line bounds.top_left, bounds.top_right
        line bounds.bottom_left, bounds.bottom_right
      end
    end
  end

  def item_header
    ["Subject", "Class Mark", "Test Mark", "Comment"]
  end

  def item_rows
    @results.map do |r|
      @subject = Subject.find(r.subject_id)
      [@subject.name, r.classmark, r.testmark, r.comment]
    end
  end

  def item_table_data
    [item_header, *item_rows] 
  end

  def table_content
    table(item_table_data) do
      row(0).font_style = :bold
      self.row_colors = ["DDDDDD", "FFFFFF"]
      self.header = true
    end
  end
  
  def teacher_comment_box
    bounding_box([0, 200], :width => 250, :height => 50) do
      text @report.teacher_comment, size: 12
      text @report.teacher + " (Class Teacher)", size: 12, format: :italic
      stroke do
        line bounds.top_left, bounds.top_right
        line bounds.bottom_left, bounds.bottom_right
        line bounds.top_left, bounds.bottom_left
      end
    end
  end
  
  def principal_comment_box
    bounding_box([0, 260], :width => 250, :height => 70) do
      text @report.principal_comment, size: 12
      text "School reopens on " + @term.startdate.to_formatted_s(:long)
      text "Yours faithfully"
      text @report.principal + " (Principal)", size: 12, format: :italic
    end
  end
end
class ReportPdfLandscape < Prawn::Document
  def initialize(report)
    super({:page_size => 'A4', :page_layout => :landscape})
    @report = Report.find(report.id)
    @student = Student.find(report.student_id)
    @term = Term.find(report.term_id)
    @next_term = Term.where("startdate > ?", @term.startdate).order("startdate ASC").first
    @results = Result.where(report_id: report.id)
    @average_class = Result.where(report_id: report.id).average(:classmark).round
    @average_test = Result.where(report_id: report.id).average(:testmark).round
    @grade = Grade.find_by(student_id: report.student_id, year: @term.year)
    @level = Level.find_by_id(@grade.level_id)
    @grand_total = 0
    @number_of_subjects = 0
    @user = User.find(report.user_id)
    @midyear = false

    header
    text_content
    move_down 50
    table_content
    teacher_comment_box
    principal_comment_box
    
    # If it is the second term, then an additional page showing midterm results will be added to the report
    if @term.term == '2'
      @midyear = true
      @terms = Term.where(year: @term.year, term: ['1','2'])
      @reports = Report.where(student_id: @student.id, term_id: @terms).pluck(:id)
      @results = Result.find_by_sql(
        ["select subject_id, avg(testmark) as testmark, avg(classmark) as classmark from results where report_id in (?) group by subject_id", @reports])
      @average_class = Result.where(report_id: @reports).average(:classmark).round
      @average_test = Result.where(report_id: @reports).average(:testmark).round
      @grand_total = 0
      @number_of_subjects = 0

      start_new_page
      header
      text_content
      move_down 50
      table_content
    end
  end

  def header
    y_position = cursor - 30
    bounding_box([0, y_position], :width => 290, :height => 50) do
      text @user.schoolname, size: 25, style: :bold, align: :left
    end
    y_position = cursor - 5
    bounding_box([0, y_position], :width => 200, :height => 110) do
      image "#{Rails.root}/app/assets/images/MARKSLOGO.png", width: 192, height: 105
    end

  end

  def text_content
    # The cursor for inserting content starts on the top left of the page. 
    # Here we move it down a little to create more space between the text and the image inserted above
    y_position = cursor + 150

    # The bounding_box takes the x and y coordinates for positioning its content and some options to style it
    bounding_box([300, y_position], :width => 300, :height => 110) do
      move_down 10
      if @midyear == true
        text "MIDYEAR " + @term.year, size: 20, style: :bold, align: :center
      else
        text "TERM " + @term.term + " " + @term.year, size: 20, style: :bold, align: :center
      end
      text "GRADE " + @level.name, size: 20, style: :bold, align: :center
      text @student.firstname + " " + @student.surname, size: 25, style: :bold, align: :center
      move_down 10
      stroke do
        line bounds.top_left, bounds.top_right
        line bounds.bottom_left, bounds.bottom_right
      end
    end
  end

  def item_header
    if @midyear == true
      ["Subject", "", "", "", "", "Total"]
    else
      ["Subject", "", "", "", "", "Total", "Comment"]
    end
  end

  def item_rows
    @results.map do |r|
      @subject = Subject.find(r.subject_id)
      @markpercent = Markpercent.find_by(level_id: @level.id, subject_id: r.subject_id)
      subject_total = (r.classmark * @markpercent.mark1_percentage / 100) + (r.testmark * @markpercent.mark2_percentage / 100)
      @grand_total = @grand_total + subject_total
      @number_of_subjects = @number_of_subjects + 1
      if @midyear == true
        [@subject.name, 
        @markpercent.mark1_label + " (" + @markpercent.mark1_percentage.to_s + "%)", 
        r.classmark.round, 
        @markpercent.mark2_label + " (" + @markpercent.mark2_percentage.to_s + "%)", 
        r.testmark.round, 
        subject_total.round]
      else
        [@subject.name, 
        @markpercent.mark1_label + " (" + @markpercent.mark1_percentage.to_s + "%)", 
        r.classmark.round, 
        @markpercent.mark2_label + " (" + @markpercent.mark2_percentage.to_s + "%)", 
        r.testmark.round, 
        subject_total.round, 
        r.comment]
      end

    end
  end
  
  def item_average
    @average_total = @grand_total / @number_of_subjects
    if @midyear == true
      ["Average", "",@average_class, "", @average_test, @average_total.round]
    else
      ["Average", "",@average_class, "", @average_test, @average_total.round, ""]
    end
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
      if @midyear == true
        self.column_widths = [100,100,50,100,50,50]
      else
        self.column_widths = [100,100,50,100,50,50,250]
      end
    end
  end

  def teacher_comment_box
    y_position = cursor - 20
    bounding_box([0, y_position], :width => 300, :height => 100) do
      move_down 10
      text @report.teacher_comment, size: 12
      move_down 10
      text @report.teacher + " (Class Teacher)", size: 12, style: :italic
      move_down 10
      stroke do
        line bounds.top_left, bounds.top_right
        line bounds.bottom_left, bounds.bottom_right
      end
    end

  end
  
  def principal_comment_box
    y_position = cursor + 100
    bounding_box([400, y_position], :width => 300, :height => 100) do
      move_down 10
      text @report.principal_comment, size: 12
      move_down 10
      unless @next_term.nil?
      text "School reopens on " + @next_term.startdate.strftime("%A, #{@next_term.startdate.day.ordinalize} %B %Y") + ".", size: 12
      end
      move_down 10
      text @report.principal + " (Principal)", size: 12, style: :italic
      stroke do
        line bounds.top_left, bounds.top_right
        line bounds.bottom_left, bounds.bottom_right
      end
    end
  end
end
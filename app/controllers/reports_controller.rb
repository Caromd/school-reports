class ReportsController < ApplicationController
  before_action :set_report, only: [:show, :edit, :update, :destroy, :pdf]
  before_action :authenticate_user!

  # GET /reports
  # GET /reports.json
  def index
    @reports = current_user.reports.all
  end
  
  def pdf
    pdf = ReportPdfLandscape.new(@report)
#    @student = Student.find(@report.student_id)
#    @term = Term.find(@report.term_id)
#    filename = File.join(@student.firstname, "_" , @student.surname , "_" , @term.year , "_" , @term.term , ".pdf")
#    filename = @student.firstname + "_" + @student.surname + "_" + @term.year + "_" + @term.term + ".pdf"
#    pdf.render_file filename
#    @filename = @student.firstname + "_" + @student.surname + "_" + @term.year + "_" + @term.term + ".pdf"
#    send_data pdf.render, filename: 'report.pdf', type: 'application/pdf'
    send_data pdf.render, filename: 'report.pdf', type: 'application/pdf'
  end

  # GET /reports/1
  # GET /reports/1.json
  def show
  end

  # GET /reports/new
  def new
#    @report = Report.new
    @report = current_user.reports.build
  end

  # GET /reports/1/edit
  def edit
  end

  # POST /reports
  # POST /reports.json
  def create
#    @report = Report.new(report_params)
    @report = current_user.reports.build(report_params)
    respond_to do |format|
      if @report.save
        format.html { redirect_to reports_path, notice: 'Report was successfully created.' }
        format.json { render :index, status: :created, location: @report }
      else
        format.html { render :new }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reports/1
  # PATCH/PUT /reports/1.json
  def update
    respond_to do |format|
      if @report.update(report_params)
        format.html { redirect_to reports_path, notice: 'Report was successfully updated.' }
        format.json { render :index, status: :ok, location: @report }
      else
        format.html { render :edit }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reports/1
  # DELETE /reports/1.json
  def destroy
    @report.destroy
    respond_to do |format|
      format.html { redirect_to reports_url, notice: 'Report was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_report
      @report = Report.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def report_params
      params.require(:report).permit(:teacher, :teacher_comment, :principal, :principal_comment, :student_id, :term_id, results_attributes: [:id,:classmark, :testmark, :subject_id, :comment , :_destroy])
    end
end

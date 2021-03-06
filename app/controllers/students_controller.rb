class StudentsController < ApplicationController
  before_action :set_student, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /students
  # GET /students.json
  def index
    @students = current_user.students.all.order('firstname asc')
  end

  # GET /students/1
  # GET /students/1.json
  def show
  end

  # GET /students/new
  def new
     @student = current_user.students.build
     @levels = current_user.levels.order('name asc')
  end

  # GET /students/1/edit
  def edit
    @levels = current_user.levels.order('name asc')
  end

  # POST /students
  # POST /students.json
  def create
    @student = current_user.students.build(student_params)

    respond_to do |format|
      if @student.save
        format.html { redirect_to students_path, notice: 'Student was successfully created.' }
        format.json { render :index, status: :created, location: @student }
      else
        format.html { render :new}
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /students/1
  # PATCH/PUT /students/1.json
  def update
    respond_to do |format|
      if @student.update(student_params)
        format.html { redirect_to students_path, notice: 'Student was successfully updated.' }
        format.json { render :index, status: :ok, location: @student }
      else
        format.html { render :edit }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /students/1
  # DELETE /students/1.json
  def destroy
    @student.destroy
    respond_to do |format|
      format.html { redirect_to students_url, notice: 'Student was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student
      @student = Student.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def student_params
      params.require(:student).permit(:firstname, :surname, :dob, :user_id, :current, grades_attributes: [:id, :year, :name, :level_id, :user_id, :_destroy])
    end
end

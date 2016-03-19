class MarkpercentsController < ApplicationController
  before_action :set_markpercent, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /markpercents
  # GET /markpercents.json
  def index
    @markpercents = current_user.markpercents.all
  end

  # GET /markpercents/1
  # GET /markpercents/1.json
  def show
  end

  # GET /markpercents/new
  def new
     @markpercent = current_user.markpercents.build
  end

  # GET /markpercents/1/edit
  def edit
  end

  # POST /markpercents
  # POST /markpercents.json
  def create
    @markpercent = current_user.markpercents.build(markpercent_params)

    respond_to do |format|
      if @markpercent.save
        format.html { redirect_to markpercents_path, notice: 'Markpercent was successfully created.' }
        format.json { render :index, status: :created, location: @markpercent }
      else
        format.html { render :new}
        format.json { render json: @markpercent.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /markpercents/1
  # PATCH/PUT /markpercents/1.json
  def update
    respond_to do |format|
      if @markpercent.update(markpercent_params)
        format.html { redirect_to markpercents_path, notice: 'Markpercent was successfully updated.' }
        format.json { render :index, status: :ok, location: @markpercent }
      else
        format.html { render :edit }
        format.json { render json: @markpercent.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /markpercents/1
  # DELETE /markpercents/1.json
  def destroy
    @markpercent.destroy
    respond_to do |format|
      format.html { redirect_to markpercents_url, notice: 'Markpercent was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_markpercent
      @markpercent = Markpercent.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def markpercent_params
      params.require(:markpercent).permit(:grade_id, :subject_id, :user_id, :mark1_label, :mark1_percentage, :mark2_label, :mark2_percentage) 
    end
end
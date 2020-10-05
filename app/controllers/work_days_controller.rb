class WorkDaysController < ApplicationController
  before_action :set_work_day, only: [:show, :update, :destroy]

  # GET /work_days
  def index
    user = User.find(params[:userId])
    @work_days = user.work_days.all

    render json: @work_days
  end

  # GET /work_days/1
  def show
    render json: @work_day
  end

  # POST /work_days
  def create
    @work_day = WorkDay.new(user_id: params[:userId], start_time: params[:startTime].to_datetime, end_time: params[:endTime].to_datetime)
    
    if @work_day.save
      render json: @work_day, status: :created, location: @work_day
    else
      render json: @work_day.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /work_days/1
  def update
    if @work_day.update(id: params[:id], start_time: params[:start_time], end_time: params[:end_time])
      render json: @work_day
    else
      render json: @work_day.errors, status: :unprocessable_entity
    end
  end

  # DELETE /work_days/1
  def destroy
    @work_day.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_work_day
      @work_day = WorkDay.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def work_day_params
      params.require(:work_day).permit(:user_id, :start_time, :end_time)
    end
end

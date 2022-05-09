# frozen_string_literal: true

class ReportsController < ApplicationController
  before_action :set_report, only: %i[show edit update destroy]

  # GET /reports
  def index
    @reports = Report.all.includes(:user).order(:id)
  end

  # GET /reports/1
  def show; end

  # GET /reports/new
  def new
    @report = Report.new
  end

  # GET /reports/1/edit
  def edit; end

  # POST /reports
  def create
    @report = Report.new(report_params)
    if current_user.reports.create(report_params)
      redirect_to @report, notice: t('controllers.common.notice_create', name: Report.model_name.human)
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /reports/1
  def update
    if current_user == @report.user
      if current_user.reports.update(report_params)
        notice = t('controllers.common.notice_update', name: Report.model_name.human)
      else
        render :edit, status: :unprocessable_entity
      end
    else
      alert = t('controllers.common.alert_update_resource_of_other_user', name: Report.model_name.human)
    end
    redirect_to @report, notice: notice, alert: alert
  end

  # DELETE /reports/1
  def destroy
    if current_user == @report.user
      @report.destroy
      notice = t('controllers.common.notice_destroy', name: Report.model_name.human)
    else
      alert = t('controllers.common.alert_destroy_resource_of_other_user', name: Report.model_name.human)
    end
    redirect_to reports_url, notice: notice, alert: alert
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_report
    @report = Report.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def report_params
    params.require(:report).permit(:title, :body)
  end
end

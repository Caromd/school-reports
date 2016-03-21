class SummaryController < ApplicationController
  before_action :authenticate_user!

  def pdf
    pdf = AnnualSummary.new
    send_data pdf.render, filename: 'summary.pdf', type: 'application/pdf'
  end
end
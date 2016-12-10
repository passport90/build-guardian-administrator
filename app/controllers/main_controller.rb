class MainController < ApplicationController
  def index
    if morning?
      @time_of_day = "morning"
      run_morning
    else
      @time_of_day = "night"
    end
  end

  def select
    redirect_to "/" and return unless morning?

    excluded_engineer_ids = []
    if params[:excluded]
      params[:excluded].each do |id, is_excluded|
        excluded_engineer_ids << id
      end
    end

    available_engineers = Engineer.where(duty_fulfilled: false).reject do |engineer|
      excluded_engineer_ids.include? engineer.id.to_s
    end

    selected_bg = available_engineers.sample
    selected_bg.duty_date = Date.today
    selected_bg.save

    redirect_to "/"
  end

private
  def morning?
    (0...12) === Time.now.hour
  end

  def current_bg
    @current_bg ||= Engineer.where(duty_date: Date.today).first
  end

  def run_morning
    if current_bg
      render template: "main/selected" and return
    end

    @available_engineers = Engineer.where(duty_fulfilled: false)
    render template: "main/selection"
  end
end

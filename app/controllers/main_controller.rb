class MainController < ApplicationController
  def index
    if (0...12) === Time.now.hour
      @time_of_day = "morning"
      current_bg
    else
      @time_of_day = "night"
    end
  end

private
  def current_bg
    @current_bg ||= Engineer.where(duty_date: Date.today).first
  end
end

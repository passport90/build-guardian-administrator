class MainController < ApplicationController
  def index
    if (0...12) === Time.now.hour
      @time_of_day = "morning"
      morning
    else
      @time_of_day = "night"
    end
  end

private
  def current_bg
    @current_bg ||= Engineer.where(duty_date: Date.today).first
  end

  def morning
    if current_bg
      render template: "main/selected" and return
    end

    @available_engineers = Engineer.where(duty_fulfilled: false)
    render template: "main/selection"
  end
end

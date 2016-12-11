class MainController < ApplicationController
  def index
    if morning?
      @time_of_day = "morning"
      run_morning
    else
      @time_of_day = "night"
      run_night
    end
  end

  def authenticate
    redirect_to "/" and return if authenticated?
    unless params.fetch(:login, {})[:password] == "queenjaneapproximately"
      redirect_to "/" and return
    end

    session[:authenticated] = true
    redirect_to "/"
  end

  def select
    redirect_to "/" and return unless morning?
    redirect_to "/" and return if current_bg

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
    redirect_to "/" and return unless selected_bg
    selected_bg.duty_date = Date.today
    selected_bg.save

    redirect_to "/"
  end

  def begin_round
    redirect_to "/" and return unless morning?
    redirect_to "/" and return if current_bg

    Engineer.all.update(duty_fulfilled: false, duty_date: nil)
    redirect_to "/"
  end

  def pay_duty_debt
    redirect_to "/" and return unless morning?
    redirect_to "/" and return if current_bg

    duty_debtor = Engineer.where(duty_owed: true).first
    redirect_to "/" and return unless duty_debtor

    duty_debtor.duty_owed = false
    duty_debtor.duty_date = Date.today
    duty_debtor.save

    redirect_to "/"
  end

  def conclude
    redirect_to "/" and return if morning?
    redirect_to "/" and return unless current_bg

    if params["commit"] == "Yes"
      current_bg.duty_fulfilled = true
    else
      current_bg.duty_owed = true
    end

      current_bg.save
    redirect_to "/"
  end

private
  def morning?
    (0...12) === Time.now.hour
  end

  def authenticated?
    session[:authenticated] == true
  end

  def current_bg
    @current_bg ||= Engineer.where(duty_date: Date.today).first
  end

  def run_morning
    render template: "main/selected" and return if current_bg
    render template: "main/authentication" and return unless authenticated?

    @duty_debtor = Engineer.where(duty_owed: true).first
    @available_engineers = Engineer.where(duty_fulfilled: false, duty_owed: false)
    render template: "main/selection"
  end

  def run_night
    return unless current_bg

    render template: "main/concluded_failed" and return if current_bg.duty_owed
    render template: "main/concluded_success" and return if current_bg.duty_fulfilled
    render template: "main/authentication" and return unless authenticated?

    render template: "main/conclusion"
  end
end

class EngineersController < ApplicationController
  before_action :authenticate
  def index
    @engineers = Engineer.all
  end

  def new
    @engineer = Engineer.new
  end

  def create
    Engineer.create(engineer_params)
    redirect_to engineers_path
  end

  def edit
    @engineer = find_engineer
    redirect_to engineers_path unless @engineer
  end

  def update
    engineer = find_engineer
    return redirect_to engineers_path unless engineer
    engineer.update!(engineer_params)
    redirect_to engineers_path
  end

  def destroy
    engineer = find_engineer
    return redirect_to engineers_path unless engineer
    engineer.destroy
    redirect_to engineers_path
  end

  private

  def find_engineer
    Engineer.find_by id: params[:id]
  end

  def authenticate
    return redirect_to "/" unless authenticated?
  end

  def authenticated?
    return session[:authenticated] == true
  end

  def engineer_params
    params.require(:engineer).permit(:slack_username)
  end
end

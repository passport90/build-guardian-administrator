require 'rails_helper'

describe "routing to main", :type => :routing do
  it "routes / to main#index" do
    expect(:get => "/").to route_to(:controller => "main", :action => "index")
  end
end

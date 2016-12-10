require 'rails_helper'

describe "routing to main", :type => :routing do
  it "routes GET / to main#index" do
    expect(:get => "/").to route_to(:controller => "main", :action => "index")
  end

  it "routes POST / to main#select" do
    expect(:post => "/").to route_to(:controller => "main", :action => "select")
  end
end

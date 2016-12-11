require 'rails_helper'

describe "routing to main", :type => :routing do
  it "routes GET / to main#index" do
    expect(:get => "/").to route_to(:controller => "main", :action => "index")
  end

  it "routes POST / to main#select" do
    expect(:post => "/").to route_to(:controller => "main", :action => "select")
  end

  it "routes POST /conclude to main#conclude" do
    expect(:post => "/conclude").to route_to(:controller => "main", :action => "conclude")
  end

  it "routes POST /duty_debt_payment to main#duty_debt_payment" do
    expect(:post => "/duty_debt_payment").to route_to(
      :controller => "main", :action => "duty_debt_payment"
    )
  end
end

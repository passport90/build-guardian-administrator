require 'rails_helper'

describe "routing to engineers", :type => :routing do
  it "routes GET engineers#index" do
    expect(:get => "/engineers").to route_to(:controller => "engineers", :action => "index")
  end

  it "routes POST engineers#new" do
    expect(:get => "/engineers/new").to route_to(:controller => "engineers", :action => "new")
  end

  it "routes GET engineers#create" do
    expect(:post => "/engineers").to route_to(:controller => "engineers", :action => "create")
  end

  it "routes GET engineers#edit" do
    expect(:get => "/engineers/1/edit").to route_to(:controller => "engineers", :action => "edit", :id => "1")
  end

  it "routes PUT engineers#update" do
    expect(:put => "/engineers/1").to route_to(:controller => "engineers", :action => "update", :id => "1")
  end

  it "routes DELETE engineers#destroy" do
    expect(:delete => "/engineers/1").to route_to(:controller => "engineers", :action => "destroy", :id => "1")
  end
end

require 'spec_helper'

describe Api::V1::RepositoriesController do

  before :each do
    @repo = Fabricate :first_repo
    request.env['HTTP_ACCEPT'] = "application/json"  
  end

  it "should get index repos" do
    get :index
    response.should be_successful
    json = JSON.parse(response.body)
    json.size.should == 1
  end

  it "should show repo with id" do
    get :show, {id: @repo.id}
    response.should be_successful
    json = JSON.parse(response.body)
    json["name"].should == "test"
  end

  it "should show repo with name and owner" do
    get :show, {name: @repo.name, owner: @repo.owner}
    response.should be_successful
    json = JSON.parse(response.body)
    json["name"].should == "test"
  end


  it "should handle 404" do
    get :show, {id: "fooo"}
    response.should be_not_found
  end

end

require 'spec_helper'

describe Api::V1::ContributorsController do

  before :each do
    @repo = Fabricate :first_repo
    request.env['HTTP_ACCEPT'] = "application/json"  
  end

  it "should get contributors repos" do
    get :index, {repository_id: @repo.id}
    response.should be_successful
    json = JSON.parse(response.body)
    json.size.should == 1
    json.first['login'] == "testeur1"
  end

  it "should show contributor with id" do
    get :show, {repository_id: @repo.id, id: @repo.commiters.first.login}
    response.should be_successful
    json = JSON.parse(response.body)
    json["login"].should == "testeur1"
  end

  it "should show repo contributor with name and owner" do
    get :show, {name: @repo.name, owner: @repo.owner, id: @repo.commiters.first.id}
    response.should be_successful
    json = JSON.parse(response.body)
    json["login"].should == "testeur1"
  end


  it "should handle 404" do
    get :show, {repository_id: @repo.id, id: 'foo'}
    response.should be_not_found
  end

end

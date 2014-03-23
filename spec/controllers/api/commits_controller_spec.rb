require 'spec_helper'

describe Api::V1::CommitsController do

  before :each do
    @repo = Fabricate :first_repo
    request.env['HTTP_ACCEPT'] = "application/json"  
  end

  it "should get commits repos" do
    get :index, {repository_id: @repo.id}
    response.should be_successful
    json = JSON.parse(response.body)
    json.size.should == 1
    json.first['sha'] == '543f1eb6c3247fd625cc4c85b32d75335a5482de'
  end

  it "should show commit with id" do
    get :show, {repository_id: @repo.id, id: @repo.commits.first.id}
    response.should be_successful
    json = JSON.parse(response.body)
    json["sha"].should == "543f1eb6c3247fd625cc4c85b32d75335a5482de"
  end

  it "should show repo contributor with name and owner" do
    get :show, {name: @repo.name, owner: @repo.owner, id: @repo.commits.first.sha}
    response.should be_successful
    json = JSON.parse(response.body)
    json["sha"].should == "543f1eb6c3247fd625cc4c85b32d75335a5482de"
  end


  it "should handle 404" do
    get :show, {repository_id: @repo.id, id: 'foo'}
    response.should be_not_found
  end

end

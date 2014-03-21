require 'spec_helper'

describe RepositoriesController, :type => :controller do

  before :each do
    @repo = Fabricate(:first_repo)
  end

  it "should show repo" do
    get :show, {owner: @repo.owner, name: @repo.name}
    response.should be_success
  end

  it "should get partial page chart" do
    get :chart, {owner: @repo.owner, name: @repo.name}
    response.should be_success
  end

  it "should get partial page committers" do
    get :committers, {owner: @repo.owner, name: @repo.name}
    response.should be_success
  end

  it "should get partial page commits" do
    get :commits, {owner: @repo.owner, name: @repo.name}
    response.should be_success
  end

end

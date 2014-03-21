require 'spec_helper'
require 'sidekiq/testing'

describe RepositoriesWorker do

  before :each do
    @repo = Fabricate(:first_repo)
    Sidekiq::Worker.clear_all
  end

  it "perfom should push correct job" do
    expect {RepositoriesWorker.perform_async(@repo.owner,@repo.name)}.to change(RepositoriesWorker.jobs, :size).by(1)
    RepositoriesWorker.jobs.first['retry'].should == false
    RepositoriesWorker.jobs.first['queue'].should == 'high'
  end

end

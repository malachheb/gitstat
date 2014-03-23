require 'spec_helper'

describe Github::Repository do
  
  before do
    stub_repo
    stub_search_repos
    stub_contributors
    stub_commits
  end
  
  it "should get Repository" do
    repo = Github::Repository.get_repository('testeur', 'test')
    repo[:name].should == 'test'
    repo[:owner].should == 'testeur'
    repo[:description] == 'test desciption'
    repo[:stars].should == 12
    repo[:forks].should == 23
    repo[:updated_at].should == Date.new(2014,1)
  end
  
  it "should search repos" do
    repos = Github::Repository.search_repositories('test', 1, 2)
    repos.total_count.should == 40
    repos.items.size.should == 2
    repos.items[0].should_not be_empty
    repos.items[1].should_not be_empty
  end
  
  it "should get contributors" do
    contris = Github::Repository.get_contributors('testeur', 'test')
    contris.size.should == 2
    contris[0].should_not be_empty
    contris[1].should_not be_empty
  end
  
  it "should get commits" do
    commits = Github::Repository.get_commits('testeur', 'test')
    commits.size.should == 2
    commits[0].should_not be_empty
    commits[1].should_not be_empty
    commits.first.sha.should == "6dcb09b5b57875f334f61aebed695e2e4193db5e"
  end

end

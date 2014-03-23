require 'spec_helper'

describe Repository do
  let!(:repo) {Fabricate.build(:first_repo)}

  subject { repo }

  it { should have_field(:github_id).of_type(String) }
  it { should have_field(:name).of_type(String) }
  it { should have_field(:owner).of_type(String) }
  it { should have_field(:description).of_type(String) }
  it { should have_field(:stars).of_type(Integer) }
  it { should have_field(:forks).of_type(Integer) }
  it { should have_field(:public).of_type(Boolean) }
  it { should have_field(:updated_at).of_type(DateTime) }

  it { should validate_presence_of(:github_id) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:owner) }
  it { should validate_uniqueness_of(:github_id) }

  context "from github" do
    before do
      stub_repo
      stub_contributors
      stub_commits
    end

    it "should create repo" do
      repository = Github::Repository.get_repository("testeur", "test")
      Repository.create_repo(repository)
      Repository.first.should_not be_nil
      Repository.first.name.should == "test"
      Repository.first.commits.size == 2
      Repository.first.commiters.size == 2
    end

    it "should update repo" do
      repo = Fabricate(:first_repo)
      repo_from_github =  repository = Github::Repository.get_repository("testeur", "test")
      repo.update_repo(repo_from_github)
      repo.updated_at.should == Date.new(2014,1)
      repo.commits.size.should == 4
      repo.commiters.size.should == 3
    end

  end

end

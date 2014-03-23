Fabricator(:first_repo, :from => :repository) do
  github_id "543"
  name "test"
  owner "testeur"
  description "test description"
  stars 23
  forks 12
  updated_at Date.new(2013,11,1)
  public true
  commiters {[Fabricate.build(:testeur1)]}
  commits {[Fabricate.build(:first_commit), Fabricate.build(:second_commit)]}
end

Fabricator(:first_repo, :from => :repository) do
  github_id "543"
  name "firstrepo"
  owner "testeur1"
  description "test description"
  stars 23
  forks 12
  updated_at Date.new(2014,2,20)
  public true
end

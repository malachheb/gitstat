Fabricator(:first_commit, :from => :commit) do
  sha "543f1eb6c3247fd625cc4c85b32d75335a5482de"
  date Date.new(2014,1)
  message 'test message commit'
  committer 'testeur1'
  additions 12
  deletions 20
end

Fabricator(:second_commit, :from => :commit) do
  sha "643f1eb6c3247fd625cc4c85b32d75335a5482de"
  date Date.new(2014,1,2)
  message 'test message commit'
  committer 'testeur2'
  additions 15
  deletions 30
end

Fabricator(:third_commit, :from => :commit) do
  sha "743f1eb6c3247fd625cc4c85b32d75335a5482de"
  date Date.new(2014,2)
  message 'test message commit'
  committer 'testeur3'
  additions 19
  deletions 10
end

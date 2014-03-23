require 'ostruct'
require 'webmock/rspec'
include WebMock::API

def stub_repo
  repo = OpenStruct.new({ id: '123',
                          name: 'test', 
                          owner:  OpenStruct.new({ login: 'testeur' }), 
                          description: 'test desciption', 
                          html_url: '',
                          stargazers_count: 12,
                          forks_count: 23,
                          updated_at: Date.new(2014,1)
                        })
  stub_request(:get, "https://api.github.com/repos/testeur/test")
    .to_return(:status => 200, :body => repo, :headers => {})
end

def stub_search_repos
  repos = OpenStruct.new({
                           total_count: 40,
                           items: [OpenStruct.new({
                                                    id: 3081286,
                                                    name: "Tetris",
                                                    full_name: "dtrupenn/Tetris",
                                                    owner: OpenStruct.new({
                                                                            login: "dtrupenn",
                                                                            id: 872147,
                                                                            gravatar_id: "e7956084e75f239de85d3a31bc172ace",
                                                                            url: "https://api.github.com/users/dtrupenn",
                                                                          }),
                                                    private: false,
                                                    html_url: "https://github.com/dtrupenn/Tetris",
                                                    description: "A C implementation of Tetris using Pennsim through LC4",
                                                    updated_at: "2013-01-05T17:58:47Z",
                                                    stargazers_count: 1,
                                                    watchers_count: 1,
                                                    forks_count: 0,
                                                  }),
                                   OpenStruct.new({
                                                    id: 3081287,
                                                    name: "calamum",
                                                    full_name: "malachheb/calamum",
                                                    owner: OpenStruct.new({
                                                                            login: "dtrupenn",
                                                                            id: 872147,
                                                                            gravatar_id: "e7956084e75f239de85d3a31bc172ace",
                                                                          }),
                                                    private: false,
                                                    html_url: "https://github.com/malachheb/calamum",
                                                    description: "A C implementation of Tetris using Pennsim through LC4",
                                                    updated_at: "2013-01-05T17:58:47Z",
                                                    stargazers_count: 1,
                                                    watchers_count: 1,
                                                    forks_count: 0,
                                                  })
                                  ]
                         })
  stub_request(:get, "https://api.github.com/search/repositories?page=1&per_page=2&q=test")
    .to_return(:status => 200, :body => repos, :headers => {})
end

def stub_contributors
  conts =  [
            OpenStruct.new({
                             login: "octocat",
                             id: 1,
                             avatar_url: "https://github.com/images/error/octocat_happy.gif",
                             gravatar_id: "somehexcode",
                             contributions: 32
                           }),
            OpenStruct.new({
                             login: "malachheb",
                             id: 1,
                             avatar_url: "https://github.com/images/error/octocat_happy.gif",
                             gravatar_id: "somehexcode",
                             contributions: 10
                           })
           ]
  stub_request(:get, "https://api.github.com/repos/testeur/test/contributors")
    .to_return(:status => 200, :body => conts, :headers => {})
end

def stub_commits
  commits = [
              OpenStruct.new({
                               sha: "6dcb09b5b57875f334f61aebed695e2e4193db5e",
                               commit: OpenStruct.new({committer: OpenStruct.new({date: "2011-04-14T16:00:49Z"}),message: "Fix all the bugs"}),
                               committer: OpenStruct.new({login: "octocat"})
                             }),
              OpenStruct.new({
                               sha: "6dcb09b5b57875f334f61aebed695e2e4193dbGf",
                               commit: OpenStruct.new({committer: OpenStruct.new({date: "2011-04-14T16:00:49Z"}),message: "test commit"}),
                               committer: OpenStruct.new({login: "testeur"})
                             })
             ]

  stub_request(:get, "https://api.github.com/repos/testeur/test/commits?per_page=100")
    .to_return(:status => 200, :body => commits, :headers => {})
  stub_request(:get, "https://api.github.com/repos/testeur/test/commits?per_page=100&since=2013-11-01T00:00:00%2B00:00")
    .to_return(:status => 200, :body => commits, :headers => {})
end

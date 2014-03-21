class Github::Repository
  include HTTParty

  base_uri 'https://api.github.com'

  def initialize(owner, name)
      @owner = owner
      @name = name
      @auth = { :username => 'malachheb', :password => 'cout123' }
  end

  def user(id)
    self.class.get("/users/#{id}", {:basic_auth =>@auth,  :headers => {"User-Agent" => "malachheb"} })
  end

  def self.get_repository(owner, name)
    repo = Octokit.repository({owner: owner, name: name})
     {github_id: repo.id,name: repo.name,owner: repo.owner.login,description: repo.description,url: repo.html_url,
      stars: repo.stargazers_count.to_i,forks: repo.forks_count.to_i,updated_at: repo.updated_at}
  end

    def self.search_repositories(q, page, per_page)
      repos = Octokit.search_repositories(q, {page: page, per_page: per_page})
    end

    def self.get_contributors(owner, name)
      contribs = Octokit.contributors({owner: owner, name: name})
    end

    def self.get_commits(owner, name, since= nil)
      options = {per_page: 100}
      options[:since] = since unless since.nil?
      commits = Octokit.commits("#{owner}/#{name}", nil, options)
      #response = self.class.get("/repos/#{@owner}/#{@name}/commits?page=1&per_page=100", {:headers => {"User-Agent" => "malachheb"} })
      commits.map do |commit|
        result = {sha: commit.sha,date: commit.commit.committer.date,message: commit.commit.message,committer: commit.committer.try(:login)}
      end
    end
end

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

  	def get_repository
  		response = self.class.get("/repos/#{@owner}/#{@name}", {:basic_auth =>@auth, :headers => {"User-Agent" => "malachheb"} })
  	  {github_id: response["id"],
        name: response["name"],
        owner: response["owner"]["login"],
        description: response["description"],
        url: response["html_url"],
        stars: response["stargazers_count"].to_i,
        forks: response["forks_count"].to_i}

    end

    def self.search_repositories(q, page, per_page)
      repos = Octokit.search_repositories(q, {page: page, per_page: per_page})
      #response = self.class.get("/search/repositories?q=#{q}", {:headers => {"User-Agent" => "malachheb"} })
      # items = repos.items.map do |repo|
      #   {
      #     name: repo.name,
      #     description: repo.description,
      #     stargazers_count: repo.stargazers_count,
      #     forks_count: repo.forks_count,
      #     owner: repo.owner.login,
      #     avatar_url: repo.owner.avatar_url
      #   }
      # end
    end
    
    def get_contributors(owner, name)
      contribs = Octokit.contributors({owner: owner, name: name})
    end

    def get_commits
      response = self.class.get("/repos/#{@owner}/#{@name}/commits?page=1&per_page=100", {:headers => {"User-Agent" => "malachheb"} })
      response.map do |commit|
        result = {
          sha: commit["sha"],
          url: commit["url"],
          date: commit["commit"]["committer"]["date"],
          message: commit["commit"]["message"],
        }
        unless commit["committer"].nil?
          result[:author] = {login: commit["committer"]["login"], github_id: commit["committer"]["id"], avatar: commit["committer"]["avatar_url"]}
        end
        result
      end
    end 
end

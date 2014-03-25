class Github::Repository
  
  def self.get_repository(owner, name)
    repo = OCTOKIT_CLIENT.repository({owner: owner, name: name})
    {github_id: repo.id,name: repo.name,owner: repo.owner.login,description: repo.description,url: repo.html_url,
      stars: repo.stargazers_count.to_i,forks: repo.forks_count.to_i,updated_at: repo.updated_at}
  end
  
  def self.search_repositories(q, page, per_page)
    repos = OCTOKIT_CLIENT.search_repositories(q, {page: page, per_page: per_page})
  end

  def self.get_contributors(owner, name)
    contribs = OCTOKIT_CLIENT.contributors({owner: owner, name: name})
  end

  def self.get_commits(owner, name, since= nil)
    options = {per_page: 100}
    options[:since] = since unless since.nil?
    OCTOKIT_CLIENT.commits("#{owner}/#{name}", nil, options)
  end

end

class Repository
  include Mongoid::Document
  include Mongoid::Timestamps
  
  embeds_many :commits
  embeds_many :commiters

  field :github_id, type: String
  field :name, type: String
  field :owner, type: String
  field :description, type: String
  field :url, type: String
  field :stars, type: Integer
  field :forks, type: Integer
  field :public, type: String

  validates_presence_of :github_id, :name, :owner

  index({ name: 1 }, { unique: true, background: true })
  index({ github_id: 1 }, { unique: true, background: true })

  def self.find_or_fetch(owner, name)
    repo = where(owner: owner, name: name).first
    if repo.nil?
      github_repository = Github::Repository.new(owner, name)
      repository = github_repository.get_repository
      repo = Repository.new(repository)
      if repo.save
        #collaborators = github_repository.get_collaborators
        #repo.find_or_create_collaborators(collaborators)
        commits = github_repository.get_commits
        repo.find_or_create_commits(commits)
      end
    end
    repo
  end

  def find_or_create_commits(commits)
    commits.each do |commit|
      commiter = commit.delete(:author)
      co = self.commits.find_or_initialize_by(commit)
      if co.save!
        unless commiter.nil?
          co_user = co.build_commiter(commiter)
          co_user.save!
        end 
      end
    end
  end

  def committers
    self.commits.map{|c| c.commiter}.compact.uniq{|u| u.login}
  end

  def find_or_create_contributors(contributors)
    contributors.each do |contributor|
      self.commiters.find_or_create_by({login: contributor.login, github_id: contributor.id, gravatar_id: contributor.gravatar_id})
    end
  end

end
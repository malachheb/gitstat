class Repository
  include Mongoid::Document

  embeds_many :commits
  embeds_many :commiters

  field :github_id, type: String
  field :name, type: String
  field :owner, type: String
  field :description, type: String
  field :url, type: String
  field :stars, type: Integer
  field :forks, type: Integer
  field :public, type: Boolean
  field :updated_at, type: DateTime

  validates_presence_of :github_id, :name, :owner
  validates_uniqueness_of :github_id

  index({ name: 1 }, { unique: true, background: true })
  index({ github_id: 1 }, { unique: true, background: true })

  def self.find_or_fetch(owner, name)
    repo = where(owner: owner, name: name).first
    repository = Github::Repository.get_repository(owner, name)
    if repo.nil?
      repo = create_repo(repository)
    end
    repo
  end

  def self.create_repo(repository)
    repo = Repository.new(repository)
    if repo.save
      contributors =  Github::Repository.get_contributors(repo.owner,repo.name)
      repo.find_or_create_contributors(contributors) unless contributors.empty?
      commits =  Github::Repository.get_commits(repo.owner, repo.name)
      repo.find_or_create_commits(commits)
    end
    repo
  end

  def update_repo(params)
    since = self.updated_at.iso8601
    if self..update_attributes(params)
      commits =  Github::Repository.get_commits(self.owner, self.name, since)
      self.find_or_create_commits(commits)
      update_commiters(commits)
    end
  end

  def find_or_create_commits(commits)
    commits.each do |commit|
      params = {sha: commit.sha,date: commit.commit.committer.date,message: commit.commit.message,committer: commit.committer.try(:login)}
      self.commits.find_or_create_by(params)
    end
  end

  def update_commiters(commits)
    commits.each do |commit|
      cont =  commit.committer
      committer = self.commiters.where(login: cont.login).first
      unless committer.nil?
        committer.update_attributes({contributions: (committer.contributions+1) })
      else
        self.commiters.create({login: cont.login, github_id: cont.id, gravatar_id: cont.gravatar_id, contributions: 1 })
      end
    end
  end

  def committers
    self.commits.map{|c| c.commiter}.compact.uniq{|u| u.login}
  end

  def find_or_create_contributors(contributors)
    contributors.each do |contributor|
      self.commiters.find_or_create_by({login: contributor.login, github_id: contributor.id, gravatar_id: contributor.gravatar_id, contributions: contributor.contributions })
    end 
  end

  def contributor_commits(login)
    commits.where(committer: login).count
  end

end

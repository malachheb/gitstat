class Commit
  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :repository

  field :sha, type: String
  field :date, type: DateTime
  field :message, type: String
  field :committer, type: String
  field :additions, type: Integer
  field :deletions, type: Integer

  validates_presence_of :sha, :date

  index({ sha: 1 }, { unique: true, background: true })

  def commiter
    self.repository.commiters.where(login: self.committer).first
  end

end

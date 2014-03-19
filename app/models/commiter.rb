class Commiter
  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :commit

  field :github_id, type: String
  field :login, type: String
  field :gravatar_id, type: String
  field :contributions, type: Integer

  validates_presence_of :github_id, :login

  index({ login: 1 }, { unique: true, background: true })
  index({ github_id: 1 }, { unique: true, background: true })

end

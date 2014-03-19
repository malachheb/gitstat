class Commit
  include Mongoid::Document
  include Mongoid::Timestamps
  
  embedded_in :repository
  

  field :sha, type: String
  field :url, type: String
  field :date, type: Date
  field :message, type: String
  field :additions, type: Integer
  field :deletions, type: Integer

  validates_presence_of :sha, :date

  index({ sha: 1 }, { unique: true, background: true })

end
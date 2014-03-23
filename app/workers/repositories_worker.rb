class RepositoriesWorker
  include Sidekiq::Worker
  sidekiq_options queue: "high"
  sidekiq_options retry: false

  def perform(owner, name)
    begin
      @repo = Repository.where(owner: owner, name: name).first
      repository = Github::Repository.get_repository(owner, name)
      if @repo.nil?
        Repository.create_repo(repository)
      elsif @repo.updated_at < repository[:updated_at]
        @repo.update_repo(repository)
        #WebsocketRails[:repos].trigger 'update', {name: name, owner: owner}
      end
    rescue Octokit::Conflict,Octokit::NotFound => e
      WebsocketRails[:repos].trigger 'error', {name: name, owner: owner, message: e.message }
    else
      WebsocketRails[:repos].trigger 'new', {name: name, owner: owner}
    end
  end
  
end

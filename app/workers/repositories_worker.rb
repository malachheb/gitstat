class RepositoriesWorker
  include Sidekiq::Worker
  sidekiq_options queue: "high"
  sidekiq_options retry: false

  def perform(owner, name)
    begin
      @repo = Repository.where(owner: owner, name: name).first
      repository = Github::Repository.get_repository(owner, name)
      if @repo.nil?
        begin
          Repository.create_repo(repository)
        rescue Octokit::Conflict => e
          WebsocketRails[:repos].trigger 'error', {name: name, owner: owner, message: e.message }
        rescue Octokit::NotFound => e
          WebsocketRails[:repos].trigger 'error', {name: name, owner: owner, message: e.message }
        else
          WebsocketRails[:repos].trigger 'new', {name: name, owner: owner}
        end
      elsif @repo.updated_at < repository[:updated_at]
        @repo.update_repo(repository)
        WebsocketRails[:repos].trigger 'update', {name: name, owner: owner}
      end
    rescue Exception => e
      WebsocketRails[:repos].trigger 'error', {name: name, owner: owner, message: e.message}
    end
  end

end

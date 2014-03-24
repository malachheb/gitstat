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
    rescue Octokit::Conflict => e
      send_error_message(owner, name, "Project #{owner}/#{name} is empty")
    rescue Octokit::NotFound => e
      send_error_message(owner, name, "Project #{owner}/#{name} is not found")
    rescue Octokit::ServiceUnavailable => e
      send_error_message(owner, name, "Service Github API unavailable")
    else
      WebsocketRails[:repos].trigger 'new', {name: name, owner: owner}
    end
  end

  def send_error_message(owner, name, message)
    WebsocketRails[:repos].trigger 'error', { name: name, owner: owner, message: message }
  end 
  
end

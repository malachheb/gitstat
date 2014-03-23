class Api::V1::CommitsController < API::ApplicationController
  
  before_filter :find_commit, :only => %w[show]
    
  def index
    find_repo
    @commits = @repo.commits
    respond_with @commits
  end

  def show
    respond_with @commit
  end

  private

  def find_repo
    @repo = Repository.where(:owner => params[:owner], :name => params[:name]).first ||
      Repository.find(params[:repository_id])
  end

  def find_commit
    find_repo
    @commit = @repo.commits.where(:sha => params[:id] ).first ||
      @repo.commits.find(params[:id])
  end
  

end

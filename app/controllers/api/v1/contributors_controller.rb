class Api::V1::ContributorsController < API::ApplicationController
  
  before_filter :find_contributor, :only => %w[show]
    
  def index
    find_repo
    @contributors = @repo.commiters
    respond_with @contributors
  end

  def show
    respond_with @contributor
  end

  private

  def find_repo
    @repo = Repository.where(:owner => params[:owner], :name => params[:name]).first ||
      Repository.find(params[:repository_id])
  end

  def find_contributor
    find_repo
    @contributor = @repo.commiters.where(:login => params[:id] ).first ||
      @repo.commiters.find(params[:id])
  end
  

end

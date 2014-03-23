class Api::V1::RepositoriesController < API::ApplicationController
  
  before_filter :find_repo, :only => %w[show contributors commits]
  
  def index
    @repos = Repository.all
    filter_repos
    respond_with @repos
  end

  def show
    respond_with @repo
  end

  # def contributors
  #   render :json => @repo.commiters, :status => 200
  # end

  # def commits
  #   render :json => @repo.commits, :status => 200
  # end

  def find_repo
    @repo = Repository.where(:owner => params[:owner], :name => params[:name]).first ||
      Repository.find(params[:id])
  end

  private
  
  def filter_repos
    @repos.select!{|r| r.name == params['name']} unless params['name'].nil?
    @repos.select!{|r| r.owner == params['owner']} unless params['owner'].nil?
  end


end

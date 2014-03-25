class RepositoriesController < ApplicationController
  def index
  end
  
  def show
    @repo = Repository.where(owner: params[:owner], name: params[:name]).first
    RepositoriesWorker.perform_async(params[:owner], params[:name])
  end

  def search
    @page = (params[:page] || 1).to_i
    repos = Github::Repository.search_repositories(params[:q],@page, PER_PAGE)
    @items = repos.items
    @total = repos.total_count
  end

  def chart
    @repo = Repository.where(owner: params[:owner], name: params[:name]).first
    @chart_user = params[:user]
    render :partial => "chart", :layout => false
  end

  def committers
    @repo = Repository.where(owner: params[:owner], name: params[:name]).first
    render :partial => "committers", :layout => false
  end

  def commits
    @repo = Repository.where(owner: params[:owner], name: params[:name]).first
    render :partial => "timeline", :layout => false
  end

end

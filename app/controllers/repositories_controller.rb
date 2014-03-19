class RepositoriesController < ApplicationController
  def index
  end

  def show
    @repo = Repository.find_or_fetch(params[:owner], params[:name])
  end

  def search
    @page = (params[:page] || 1).to_i
    repos = Github::Repository.search_repositories(params[:q],@page,10)
    @items = repos.items
    @total = repos.total_count
  end

  def chart

  end

end

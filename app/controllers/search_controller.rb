class SearchController < ApplicationController
  def index
    WebsocketRails[:posts].trigger 'new', {name: 'malachheb'}
  end
end

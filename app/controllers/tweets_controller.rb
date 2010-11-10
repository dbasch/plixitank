class TweetsController < ApplicationController
  def index
    @docs = TweetIndexer.search(params[:query]) if params[:query].present?
  end
end

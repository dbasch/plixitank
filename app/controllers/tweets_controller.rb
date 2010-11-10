class TweetsController < ApplicationController
  def index
    @docs = Tweet.search(params[:query]) if params[:query].present?
  end
end

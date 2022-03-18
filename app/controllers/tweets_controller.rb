require './app/services/tweet_crawler'
class TweetsController < ApplicationController
  def show
    @tweets = Tweet.includes(:topics)
                  .where(topics: { name: params[:topic]} )
                  .references(:topics)
                  .order(updated_at: :desc)
                  .limit(params[:limit] ||= 10) # Allow api call to limit tweets accessed
    
    render json: @tweets
  end
end

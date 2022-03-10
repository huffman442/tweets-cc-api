require './app/services/tweet_crawler'
class TweetsController < ApplicationController
  def show
    @tweet = Tweet.includes(:topics).where(topics: { name: params[:topic]} ).references(:topics)
    render json: @tweet
  end

  def update
    TweetCrawler.new('nasa')
    TweetCrawler.new('healthcare')
    TweetCrawler.new('ruby')
    render :json => { :success => true }
    # Would like to return more information here maybe regarding num of tweets added or something
  end
end

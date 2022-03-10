require 'httparty'
class TweetCrawler
    attr_reader :data

    def initialize(topic)
        @topic = topic
        set_call_params()
        @response = get_api(@query, @headers, @uri)
        response_status()
        
        # Due to time constraints, this needs further error handling & testing for different api results(unauthorized/not found/etc.)
        @data = @response["data"]
        save_tweets()
    end

    def set_call_params
        @query = {
            "query" => @topic
        }
        @headers = { 
            "Authorization"  => ENV['TWITTER_BEARER_TOKEN']
        }
        @uri ="https://api.twitter.com/2/tweets/search/recent"
    end

    def get_api query, headers, uri
        HTTParty.get(
            uri, 
            :headers => headers,
            :query => query
        )
    end

    def response_status
        puts @response.code       # => '200'
        puts @response.message    # => 'OK'
    end

    def save_tweets
        @data.each do |tweet|
            # If tweet exists grab it, update to have this topic else save the new tweet
            if Tweet.exists?(tweet_id=tweet["id"])
                Tweet.find_by(tweet["id"]).topics.new(@topic).save
            else
                Tweet.new(tweet_id: tweet["id"]).topics.new(name: @topic).save
            end
        end
    end
end
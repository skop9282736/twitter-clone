# frozen_string_literal: true

class TweetReflex < ApplicationReflex
  include CableReady::Broadcaster
  
  def like_tweet
    tweet = Tweet.find(element.dataset[:tweetid])
    user = User.find(element.dataset[:userid])
    
    Like.create(user:user, tweet:tweet)
  end

  def submit
    @tweet = Tweet.new(tweet_params)
    @tweet.user = current_user
    debugger
  end

  private
  def tweet_params
    params.require(:tweet).permit(:body)
  end
  
end

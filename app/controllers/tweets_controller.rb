class TweetsController < ApplicationController
  before_action :set_tweet, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  include CableReady::Broadcaster


  # GET /tweets
  # GET /tweets.json
  def index
    @tweets = Tweet.order(created_at: :desc)
    @tweet = Tweet.new
    @like = Like.new
  end

  def my_tweets
    @tweets = current_user.tweets.order(created_at: :desc)
    @tweet = Tweet.new
    @like = Like.new
  end

  def like_tweet
    @like = Like.new(like_params)
    @like.tweet = Tweet.find(params[:like][:tweet_id])
    @like.user = current_user
    @like.save
    redirect_to index
  end
  


  # GET /tweets/1
  # GET /tweets/1.json
  def show
  end

  # GET /tweets/new
  def new
    @tweet = Tweet.new
  end

  # GET /tweets/1/edit
  def edit
  end

  # POST /tweets
  # POST /tweets.json
  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.user = current_user
    cable_ready["timeline-stream"].inner_html(
          selector: "#timeline", #string containing a CSS selector or XPath expression
          # position: "afterbegin",
          html: '<h2>a new tweet</h2>'
        )
    cable_ready.broadcast
    redirect_to root_path
    # respond_to do |format|
    #   if @tweet.save
    #     cable_ready["tweet_channel"].insert_adjacent_html(
    #       selector: "timeline", #string containing a CSS selector or XPath expression
    #       position: "afterbegin",
    #       html: '<h2>a new tweet</h2>'
    #     )
    #     cable_ready.broadcast
    #     format.html { redirect_to index, notice: 'Tweet was successfully created.' }
    #   else
    #     format.html { render :index }
    #   end
    # end
  end

  # PATCH/PUT /tweets/1
  # PATCH/PUT /tweets/1.json
  def update
    respond_to do |format|
      if @tweet.update(tweet_params)
        format.html { redirect_to @tweet, notice: 'Tweet was successfully updated.' }
        format.json { render :show, status: :ok, location: @tweet }
      else
        format.html { render :edit }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tweets/1
  # DELETE /tweets/1.json
  def destroy
    @tweet.destroy
    respond_to do |format|
      format.html { redirect_to tweets_url, notice: 'Tweet was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tweet
      @tweet = Tweet.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tweet_params
      params.require(:tweet).permit(:body)
    end

    def like_params
      params.require(:like).permit(:tweet_id)
    end
end

require 'open-uri'
require 'indextank_client'

class TweetIndexer
  def self.index
    @api ||= IndexTank::HerokuClient.new
    @index = @api.get_index 'plixi'

    create_index unless index.exists?
  end

  def self.create_index
    index.create_index
    while not index.running?
      puts 'waiting for index to start...'
      sleep 1
    end
  end

  # retrieve tweets from IndexTank
  def self.search(query)
    {
      :matches => 0,
      :results => []
    }
  end

  # load tweets from Plixi API into IndexTank
  def self.index
    uri = 'http://api.plixi.com/api/tpapi.svc/json/photos?getuser=true'

    photos = JSON.parse(open(uri).read)
    count, list = photos['Count'], photos['List']

    list.each do |data|
      tweet = Tweet.new(data)
      index.add_document(tweet.id, tweet.to_document) if tweet.indexable?
    end
  end
end
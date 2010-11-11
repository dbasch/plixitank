require 'open-uri'

class TweetIndexer
  def self.index
    @api ||= IndexTank::Client.new(ENV['HEROKUTANK_API_URL'])
    @index ||= @api.indexes('plixi')

    create_index unless @index.exists?

    @index
  end

  def self.create_index
    @index.add
    while not @index.running?
      puts 'waiting for index to start...'
      sleep 1
    end
  end

  # retrieve tweets from IndexTank
  def self.search(query)
    index.search(query, :snippet=>'text', :fetch=>'thumbnail_url,screen_name,plixi_id,timestamp')
  end

  # load tweets from Plixi API into IndexTank
  def self.load
    uri = 'http://api.plixi.com/api/tpapi.svc/json/photos?getuser=true'

    photos = JSON.parse(open(uri).read)
    count, list = photos['Count'], photos['List']

    list.each do |data|
      tweet = Tweet.new(data)
      index.document(tweet.id).add(tweet.to_document) if tweet.indexable?
    end
  end
end
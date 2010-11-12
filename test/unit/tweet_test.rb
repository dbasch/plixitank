require 'test_helper'

class TweetTest < ActiveSupport::TestCase
  context 'A Tweet' do
    setup do
      @tweet = Tweet.new({
        'Id' => 1,
        'Message' => 'Hello, Johnny',
        'UploadDate' => 1234567890,
        'User' => {'ScreenName' => 'hello'},
        'ThumbnailUrl' => 'http://foo.bar/baz.jpg'
      })
    end

    should 'know its ID' do
      assert_equal 1, @tweet.id
    end

    should 'documentize correctly' do
      hash = {
        :plixi_id => 1,
        :text => 'Hello, Johnny',
        :timestamp => 1234567890,
        :screen_name => 'hello',
        :thumbnail_url => 'http://foo.bar/baz.jpg'
      }
      assert_equal hash, @tweet.to_document
    end

    should 'know when it is indexable' do
      assert @tweet.indexable?
    end

    should 'pass messages to the data hash' do
      assert_nothing_raised do
        @tweet.message
        @tweet.upload_date
        @tweet.screen_name
        @tweet.thumbnail_url
      end
    end
  end
end

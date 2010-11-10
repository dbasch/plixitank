class Tweet
  def initialize(data)
    @data = data
  end

  def to_document
    {
      :plixi_id      => @data['Id'],
      :text          => @data['Message'],
      :timestamp     => @data['UploadDate'].to_i,
      :screen_name   => @data['ScreenName'],
      :thumbnail_url => @data['ThumbnailUrl']
    }
  end

  def indexable?
    @data['Message'].present?
  end
end
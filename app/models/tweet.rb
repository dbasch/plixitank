class Tweet
  def initialize(data)
    @data = data
  end

  def id
    @data['Id']
  end

  def to_document
    {
      :plixi_id      => self.id,
      :text          => self.message,
      :timestamp     => self.upload_date.to_i,
      :screen_name   => self.screen_name,
      :thumbnail_url => self.thumbnail_url
    }
  end

  def indexable?
    self.message.present?
  end

  def method_missing(name, *args, &block)
    if @data[name.to_s.classify]
      @data[name.to_s.classify]
    else
      super
    end
  end
end
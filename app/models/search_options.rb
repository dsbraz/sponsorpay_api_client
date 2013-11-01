require 'digest/sha1'

class SearchOptions
  attr_reader :data

  def initialize(data)
    @data = data
  end

  def sign(api_key)
    @data.merge!({ timestamp: Time.now.to_i })
    @data.merge!({ hashkey: Digest::SHA1.hexdigest(to_s + "&#{api_key}") })
  end

  def merge!(other)
    @data.merge!(other)
  end

  def to_s
    (@data.sort.map{ |item| item.join('=') }).join('&')
  end
end

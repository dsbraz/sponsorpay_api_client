require 'httparty'
require 'digest/sha1'

class SearchProxy
  include HTTParty

  base_uri 'http://api.sponsorpay.com/feed/v1/offers.json'

  def initialize
    @api_key = ENV['SPCH_API_KEY']
    @options = SearchOptions.new({ format: 'json', appid: '157',
                ip: '109.235.143.113', locale: 'de', offer_types: '112',
                device_id: '2b6f0cc904d137be2 e1730235f5664094b 831186' })
  end

  def search(params)
    @options.merge!(params)
    @options.sign(@api_key)
    do_get(@options)
  end

  private

  def do_get(options)
    response = self.class.get('/', { query: options.data })
    Rails.logger.debug "Calling API => #{response.request.last_uri}"
    SearchResponse.new(response, @api_key).content
  end
end

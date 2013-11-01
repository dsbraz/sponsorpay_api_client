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
    srp = SearchResponse.new(self.class.get('/', { query: options.data }), @api_key)
    Rails.logger.debug "Calling API => #{srp.last_uri}"
    srp.content
  end
end

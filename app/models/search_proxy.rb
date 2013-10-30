require 'httparty'

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
    response if valid? response
  end

  def valid?(response)
    case response.code
    when 200
      # TODO check hashkey
      true
    when 400
      raise 'Calling SponsorPay API: Bad request'
    when 401
      raise 'Calling SponsorPay API: Unauthorized'
    when 404
      raise 'Calling SponsorPay API: Not found'
    when 500
      raise 'Calling SponsorPay API: Internal Server Error'
    when 502
      raise 'Calling SponsorPay API: Bad Gateway'
    else
      raise 'Calling SponsorPay API: Unknow problem'
    end
  end
end

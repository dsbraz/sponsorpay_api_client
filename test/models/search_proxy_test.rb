require 'test_helper'

class SearchProxyTest < ActiveSupport::TestCase
  test 'should call sponsor pay api' do
    response = SearchProxy.new.search({ uid: 'player1' })
    last_uri = response.request.last_uri.to_s
    refute_nil last_uri.gsub('http://api.sponsorpay.com/feed/v1/offers.json').first
  end
end

require 'test_helper'

class SearchProxyTest < ActiveSupport::TestCase
  test 'should search on sponsor pay api' do
    response = SearchProxy.new.search({ uid: 'player1' })
    last_uri = response.request.last_uri.to_s
    refute_nil last_uri.gsub('http://api.sponsorpay.com/feed/v1/offers.json').first
  end

  test 'should process valid response' do
    assert_nothing_raised {
      SearchProxy.new.search({ uid: 'player1' })
    }
  end

  test 'should not process invalid response' do
    assert_raises(RuntimeError) {
      SearchProxy.new.search({ uid: 'player1', appid: 'abc' })
    }
  end
end

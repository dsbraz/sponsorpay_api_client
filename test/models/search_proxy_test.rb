require 'test_helper'

class SearchProxyTest < ActiveSupport::TestCase
  test 'should search on sponsor pay api' do
    response = SearchProxy.new.search({ uid: 'player1' })
    url = response['information']['support_url']
    refute_nil url.gsub('http://api.sponsorpay.com').first
  end

  test 'should return a Hash' do
    response = SearchProxy.new.search({ uid: 'player1' })
    assert_instance_of Hash, response
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

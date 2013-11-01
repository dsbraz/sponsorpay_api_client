require 'test_helper'

# Build a Fake or use a Mock Framework
class ResponseFake < Struct.new(:code)
  def request
    RequestFake.new
  end

  def body
    "bodyfake"
  end

  def header
    { 'X-Sponsorpay-Response-Signature' => 'de523e4304fa702fcf838303b51c9f8505a750ee'}
  end
end

# Build a Fake or use a Mock Framework
class RequestFake
  def last_uri
    "http://sponsorpay/fakeuri"
  end
end

class SearchResponseTest < ActiveSupport::TestCase
  test 'should know the last uri called' do
    srp = SearchResponse.new(ResponseFake.new(200))
    refute_nil srp.last_uri
  end

  test 'should validate when status is 200' do
    srp = SearchResponse.new(ResponseFake.new(200))
    assert srp.valid?('123')
  end

  test 'should raise an exception when status is 400' do
    assert_raises(RuntimeError) {
      SearchResponse.new(ResponseFake.new(400)).valid?('123')
    }
  end

  test 'should raise an exception when status is 401' do
    assert_raises(RuntimeError) {
      SearchResponse.new(ResponseFake.new(401)).valid?('123')
    }
  end

  test 'should raise an exception when status is 404' do
    assert_raises(RuntimeError) {
      SearchResponse.new(ResponseFake.new(404)).valid?('123')
    }
  end

  test 'should raise an exception when status is 500' do
    assert_raises(RuntimeError) {
      SearchResponse.new(ResponseFake.new(500)).valid?('123')
    }
  end

  test 'should raise an exception when status is 502' do
    assert_raises(RuntimeError) {
      SearchResponse.new(ResponseFake.new(502)).valid?('123')
    }
  end
end

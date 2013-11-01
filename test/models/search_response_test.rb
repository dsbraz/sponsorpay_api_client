require 'test_helper'

# Build a Fake or use a Mock Framework
class ResponseFake < Struct.new(:code)
  def request
    RequestFake.new
  end

  def body
    "bodyfake"
  end

  def parsed_response
    { a: 'a', b: 'b'}
  end

  def header
    { 'X-Sponsorpay-Response-Signature' => 'de523e4304fa702fcf838303b51c9f8505a750ee'}
  end
end

class SearchResponseTest < ActiveSupport::TestCase
  test 'should know the content hash' do
    content = SearchResponse.new(ResponseFake.new(200), '123').content
    assert_instance_of Hash, content
    refute_nil content
  end

  test 'should validate when status is 200' do
    assert_nothing_raised {
      SearchResponse.new(ResponseFake.new(200), '123')
    }
  end

  test 'should not be valid when status is 200 and the sign do not validate' do
    assert_raises(RuntimeError) {
      SearchResponse.new(ResponseFake.new(200), '1234')
    }
  end

  test 'should raise an exception when status is 400' do
    assert_raises(RuntimeError) {
      SearchResponse.new(ResponseFake.new(400), '123')
    }
  end

  test 'should raise an exception when status is 401' do
    assert_raises(RuntimeError) {
      SearchResponse.new(ResponseFake.new(401), '123')
    }
  end

  test 'should raise an exception when status is 404' do
    assert_raises(RuntimeError) {
      SearchResponse.new(ResponseFake.new(404), '123')
    }
  end

  test 'should raise an exception when status is 500' do
    assert_raises(RuntimeError) {
      SearchResponse.new(ResponseFake.new(500), '123')
    }
  end

  test 'should raise an exception when status is 502' do
    assert_raises(RuntimeError) {
      SearchResponse.new(ResponseFake.new(502), '123')
    }
  end
end

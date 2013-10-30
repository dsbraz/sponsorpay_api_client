require 'test_helper'
require 'digest/sha1'

class SearchOptionsTest < ActiveSupport::TestCase
  test 'should sort the options alphabetically' do
    options = SearchOptions.new({ b: '123', c: '123', a: '123' }).sort
    assert options == [[:a, '123'], [:b, '123'], [:c, '123']]
  end

  test 'shoud has a str representation' do
    options = SearchOptions.new({ b: '123', c: '123', a: '123' }).to_s
    assert options == 'a=123&b=123&c=123'
  end

  test 'should be able to merge the values' do
    options = SearchOptions.new({ b: '123', c: '123', a: '123' })
    options.merge!({ d: '123' })
    assert options.data == { b: '123', c: '123', a: '123', d: '123' }
  end

  test 'should sign using sha1' do
    op1 = SearchOptions.new({ b: '123', c: '123', a: '123' }).sign('123')
    hash1 = op1.delete(:hashkey)
    op2 = SearchOptions.new(op1).to_s + '&123'
    hash2 = Digest::SHA1.hexdigest(op2.to_s)
    assert hash1 == hash2
  end
end

require 'test_helper'

class OfferTest < ActiveSupport::TestCase
  test 'should be possible to search for offers' do
    offers = Offer.find_by({ uid: 'player1' })
    refute_nil offers
  end

  test 'should be an Array of Offer when hit a result' do
    offers = Offer.find_by({ uid: 'player1' })
    if !offers.empty?
      assert_instance_of Array, offers
      assert_instance_of Offer, offers[0]
    end
  end

  test 'shoud be possible to specified a valid page when searching' do
    assert_nothing_raised {
      offers = Offer.find_by({ uid: 'player1', page: 1 })
      refute_nil offers
    }
  end

  test 'shoud not be possible to specified an invalid page when searching' do
    assert_raises(RuntimeError) {
      offers = Offer.find_by({ uid: 'player1', page: 10000 })
    }
  end

  test 'shoud be possible to specified a pub0 when searching' do
    offers = Offer.find_by({ uid: 'player1', pub0: 'camp1' })
    refute_nil offers
  end
end

require 'test_helper'

class OfferTest < ActiveSupport::TestCase
  test 'should be possible to search for offers' do
    offers = Offer.find_by({ uid: 'player1' })
    refute_nil offers
  end

  test 'should be an Array of Offer when search hit' do
    offers = Offer.find_by({ uid: 'player1' })
    if !offers.empty?
      assert_instance_of Array, offers
      assert_instance_of Offer, offers[0]
    end
  end

  test 'shoud be possible to specified page when searching' do
    offers = Offer.find_by({ uid: 'player1', page: 1 })
    refute_nil offers
  end
end

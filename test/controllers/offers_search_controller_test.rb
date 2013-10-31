require 'test_helper'

class OffersSearchControllerTest < ActionController::TestCase
  test 'should get index' do
    get :index
    assert_template :index
    assert_response :success
  end

  test 'should post search' do
    get :search, uid: 'player1'
    assert_template :index
    assert_response :success
    assert assigns(:offers)
  end
end

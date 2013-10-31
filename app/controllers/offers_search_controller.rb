class OffersSearchController < ApplicationController
  # GET /offers_search
  def index
  end

  # POST /offers_search
  def search
    begin
      @offers = Offer.find_by(search_params)
    rescue RuntimeError => e
      @offers = []
      flash.now['error'] = e.message
    end
    render :index
  end

  private

  def search_params
    { uid: params['uid'], pub0: params['pub0'], page: params['page'] }
  end
end

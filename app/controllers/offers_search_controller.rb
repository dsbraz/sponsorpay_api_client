class OffersSearchController < ApplicationController
  # GET /offers_search
  def index
  end

  # POST /offers_search
  def search
    @offers = Offer.all
    render :index
  end
end

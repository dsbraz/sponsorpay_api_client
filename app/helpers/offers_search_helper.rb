module OffersSearchHelper
  def render_offers
    if @offers.nil?
      content_tag(:p, 'Search something')
    elsif @offers.empty?
      render 'no_offers'
    else
      render 'offers'
    end
  end
end

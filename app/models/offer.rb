class Offer < Struct.new(:title, :payout, :thumbnail)
  def self.find_by(params)
    Array.new.tap do |arr|
      proxy = SearchProxy.new
      content = proxy.search(params)
      content['offers'].try(:each) do |offer|
        arr << Offer.new(offer['title'], offer['payout'],
                          offer['thumbnail']['lowres'])
      end
    end
  end
end

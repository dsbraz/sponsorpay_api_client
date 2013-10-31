class Offer < Struct.new(:title, :payout, :thumbnail)
  def self.find_by(params)
    Array.new.tap do |arr|
      proxy = SearchProxy.new
      response = proxy.search(params)
      response['offers'].each do |offer|
        arr << Offer.new(offer['title'], offer['payout'],
                          offer['thumbnail']['lowres'])
      end
    end
  end
end

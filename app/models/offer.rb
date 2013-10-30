class Offer < Struct.new(:title, :payout, :thumbnail)
  def initialize
    @proxy = SearchProxy.new
  end

  def self.find_by(params)
    response = @proxy.search(params)

  end
end

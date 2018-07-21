require './lib/merchant'

class MerchantRepository

  def initialize
    @merchants = []
  end

  def create(params)
    Merchant.new(params).tap do |merchant|
      @merchants << merchant
    end
  end

end

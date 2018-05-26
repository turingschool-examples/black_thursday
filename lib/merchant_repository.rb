class MerchantRepository
  attr_reader :array, :repository
  def initialize(merchants)
    @merchants = merchants
    @repository = make_repository
  end

  def make_repository
    @merchants.map do |merchant|
      Merchant.new(merchant)
    end
  end

end

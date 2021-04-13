require './lib/merchant'
class MerchantRepository
  attr_reader :merchants
  def initialize(parsed_csv)
    @merchants = create_merchants(parsed_csv)
  end

  def create_merchants(parsed_data)
     parsed_data.map do |merchant|
      Merchant.new(merchant)
    end
  end

  def all
    @merchants
  end

  def find_by_id(id)
    @merchants.find do |merchant|
      merchant.id
    end
  end
end

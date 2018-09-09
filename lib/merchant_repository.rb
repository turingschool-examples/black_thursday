require 'pry'

class MerchantRepository

  def initialize(filepath = nil)
    @filepath = filepath
    @merchants = []
  end

  def <<(merchant)
    @merchants << merchant
  end

  def find_all_by_name(name)
    @merchants.find_all do |merchant|
      merchant_name = merchant.name.downcase
      merchant_name.include?(name.downcase)
    end
  end

end

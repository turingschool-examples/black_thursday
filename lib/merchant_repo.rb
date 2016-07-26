require './lib/merchant'

class MerchantRepo

  def initialize
    @merchants = []
  end

  def all
    @merchants
  end

  def add_merchant(merchant_details)
    @merchants << Merchant.new(merchant_details)
  end

  def find_by_id(id)
    @merchants.find do |merchant|
      merchant.id == id
    end
  end

  def find_by_name(name)
    name.downcase!
    @merchants.find do |merchant|
      merchant.name.downcase == name
    end
  end

  def find_all_by_name(name)
    name.downcase!
    @merchants.find_all do |merchant|
      merchant.name.downcase.include?(name)
    end
  end

end

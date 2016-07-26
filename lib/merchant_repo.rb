require './lib/merchant'

class MerchantRepo
  attr_reader :sales_engine

  def initialize(sales_engine = nil)
    @merchants = []
    @sales_engine = sales_engine
  end

  def all
    @merchants
  end

  def add_merchant(merchant_details)
    @merchants << Merchant.new(merchant_details, self)
  end

  def find_by_id(id)
    @merchants.find do |merchant|
      merchant.id == id
    end
  end

  def find_by_name(name)
    name.downcase!
    @merchants.find do |merchant|
      merchant.name.downcase == name.downcase
    end
  end

  def find_all_by_name(name)
    name.downcase!
    @merchants.find_all do |merchant|
      merchant.name.downcase.include?(name)
    end
  end



end

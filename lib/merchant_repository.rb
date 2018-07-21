require 'pry'

class MerchantRepository

  def initialize(merchants)
    @merchants = merchants
  end

  def all
    @merchants
  end

  def find_by_id(id)
    @merchants.find do |merchant|
      merchant.id == id
    end
  end

  def find_by_name(name)
    @merchants.find do |merchant|
      merchant.name.downcase == name.downcase
    end
  end

  def find_all_by_name(name)
    @merchants.find_all do |merchant|
      merchant.name.downcase.include?(name)
    end
  end

  def create(attributes)
    highest_merchant_id = @merchants.max_by do |merchant|
      merchant.id
    end
    attributes[:id] = highest_merchant_id.id + 1
    @merchants << Merchant.new(attributes)
  end

end

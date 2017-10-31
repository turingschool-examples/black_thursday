require './lib/merchant'
class MerchantRepository

  attr_reader :merchants

  def initialize(merchants)
    @merchants = merchants.map {|merchant| Merchant.new(merchant)}
  end

  def all
    @merchants
  end

  def find_by_id(id)
    merchants.find do |merchant|
      merchant.id = id
    end
  end

  def find_by_name(name)
    merchants.find do |merchant|
      merchant.name.upcase == name.upcase
    end
  end

  def find_all_by_name(word)
    merchants.find_all do |merchant|
      merchant.name.include?(word)
    end
  end
end

require './lib/merchant'
class MerchantRepository

  attr_reader :merchants,
              :parent

  def initialize(merchants, parent)
    @merchants = merchants.map {|merchant| Merchant.new(merchant, self)}
    @parent = parent
  end

  def all
    merchants
  end

  def find_all_items_by_merchant_id(id)
    parent.find_items_by_merchant_id(id)
  end

  def find_by_id(id)
    merchants.find do |merchant|
      merchant.id == id
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

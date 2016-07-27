require './lib/merchant'

class MerchantRepository
  attr_reader :merchants

  def initialize
    @merchants = {}
  end

  def format_merchant_info(merchant)
    {:id => merchant[:id], :name => merchant[:name]}
  end

  def populate(merchants)
    merchants.each do |merchant|
      merchant_formatted = format_merchant_info(merchant)
      @merchants[merchant[:id]] = Merchant.new(merchant_formatted)
    end
  end

  def all
    merchants.values
  end

  def find_by_id(merchant_id)
    merchants[merchant_id]
  end

  def find_by_name(merchant_name)
    merchants.values.find do |merchant|
      merchant.name.downcase == merchant_name.downcase
    end
  end

  def find_all_by_name(name_fragment)
    merchants.values.find_all do |merchant|
      merchant.name.downcase.include?(name_fragment.downcase)
    end
  end
end

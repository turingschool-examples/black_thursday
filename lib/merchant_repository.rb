require_relative 'merchant'

class MerchantRepository
  attr_reader :merchants

  def initialize(merchants_data)
    @merchants = {}
    populate(merchants_data)
  end

  # def initialize(merchants)
  #   @merchants = populate(merchants)
  # end

  def format_merchant_info(merchant)
    {:id => merchant[:id], :name => merchant[:name]}
  end

  def populate(merchants_data)
    merchants_data.each do |merchant_data|
      make_merchant(merchant_data)
    end
  end

  def make_merchant(merchant_data)
    merchant_formatted = format_merchant_info(merchant_data)
    @merchants[merchant_data[:id]] = Merchant.new(merchant_formatted)
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

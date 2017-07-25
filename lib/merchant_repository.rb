require 'simplecov'
SimpleCov.start

require 'CSV'
class MerchantRepository

  attr_reader :merchants

  def initialize(filepath)
    @merchants = []
    load_csv(filepath)
  end

  def load_csv(filepath)
    CSV.foreach(filepath, headers: true, header_converters: :symbol, converters: :numeric) do |row|
      @merchants << Merchant.new(row.to_h)
    end
  end

  def all
    @merchants
  end

  def find_by_id(merchant_id, found_merchant = '')
    @merchants.each do |merchant|
      if merchant.id == merchant_id
        found_merchant = merchant
        break
      else
        found_merchant = nil
      end
    end
    found_merchant
  end

  def find_by_name(merchant_name, found_merchant = '')
    @merchants.each do |merchant|
      if merchant.name.upcase == merchant_name.upcase
        found_merchant = merchant
        break
      else
        found_merchant = nil
      end
    end
    found_merchant
  end

  def find_all_by_name(name_fragment, found_merchants = [])
    @merchants.each do |merchant|
      if merchant.name.upcase.include?(name_fragment.upcase)
        found_merchants << merchant
      end
    end
    found_merchants
  end
end

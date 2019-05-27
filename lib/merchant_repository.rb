require 'csv'
require_relative '../lib/merchant'

class MerchantRepository
  def initialize(file_path, parent)
    @merchants = []
    @sales_engine = parent
    merchant_data = CSV.open file_path, headers: true,
      header_converters: :symbol, converters: :numeric
    from_csv(merchant_data)
  end

  def from_csv(merchant_data)
    merchant_data.each do |row|
      @merchants << Merchant.new(row.to_hash, self)
    end
  end

  def all
    return @merchants
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

  def find_all_by_name(name_fragment)
    @merchants.find_all do |merchant|
      merchant.name.downcase.include?(name_fragment.downcase)
    end
  end

  def find_items_by_id(id)
    @sales_engine.find_items_by_merchant_id(id)
  end

  def find_invoices_by_id(id)
    @sales_engine.find_invoices_by_merchant_id(id)
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end
end

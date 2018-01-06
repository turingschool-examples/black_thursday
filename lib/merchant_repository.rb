require_relative '../lib/merchant'
require 'csv'

class MerchantRepository

  attr_reader :merchants,
              :se

  def initialize(csv_file, se)
    @merchants_csv = csv_file   #CSV.open csv_file, headers: true, header_converters: :symbol
    @merchants = []
    @se = se
    @merchants_csv.each do |row|
      id          = row[:id].to_i
      name        = row[:name]
      @merchants << Merchant.new({
        name: name,
        id: id,
        merchant_repo: self
        })
    end
    @invoices = []
  end

  def inspect
    "#<#{self.class} #{@invoices.size} rows>"
  end

  def all
    @merchants
  end

  def find_by_id(id)  # Returns Merchant by Id
    @merchants.find do |merchant|
      merchant if merchant.id == id
    end
  end

  def find_by_name(name) # Returns if merchant name is == to name
    @merchants.find do |merchant|
      merchant if merchant.name.downcase == name.downcase
    end
  end

  def find_all_by_name(name) # Returns if name is included with Merchant Name
    @merchants.find_all do |merchant|
      merchant if merchant.name.downcase.include?(name.downcase)
    end
  end

  def find_item(id) # Returns Item by Merchant Id
    se.find_item_by_merchant_id(id)
  end

  def grab_array_of_items # NEEDS TESTS || Returns array of items per merchant
    merchants.map { |merchant| merchant.items.count }
  end

end

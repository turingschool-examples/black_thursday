require_relative '../lib/merchant'
require 'csv'

class MerchantRepository

  attr_reader :merchants,
              :se

  def initialize(csv_file, se)
    @merchants_csv = CSV.open csv_file, headers: true, header_converters: :symbol
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

  def find_by_id(id)
    @merchants.find do |merchant|
      merchant if merchant.id == id
    end
  end

  def find_by_name(name)
    @merchants.find do |merchant|
      merchant if merchant.name.downcase == name.downcase
    end
  end

  def find_all_by_name(name)
    @merchants.find_all do |merchant|
      merchant if merchant.name.downcase.include?(name.downcase)
    end
  end

  def find_item(id)
    se.find_item_by_merchant_id(id)
  end

  def total_merchants #Duplicate
    merchants.count
  end

  def grab_array_of_items # NEEDS TESTS
    merchants.map { |merchant| merchant.items.count }
  end

  def grab_merchants(sales_analyst) # NEEDS TESTS
    merchants.find_all do |merchant|
      merchant if merchant.items.count > sales_analyst.average_items_per_merchant_standard_deviation
    end
  end

end

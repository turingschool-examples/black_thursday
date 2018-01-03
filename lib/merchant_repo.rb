require_relative "merchant"
require_relative "sales_engine"

class MerchantRepo
  attr_reader :merchants,
              :parent

  def initialize(parent, filename)
    @merchants    = []
    @sales_engine = parent
    load_merchants(filename)
  end

  def load_merchants(filename)
    merchant_csv = CSV.open filename,
                            headers: true,
                            header_converters: :symbol,
                            converters: :numeric
    merchant_csv.each do |row| @merchants << Merchant.new(row, self)
    end
  end

  def all
    merchants
  end

  def find_by_id(id)
    merchants.find { |merchant| merchant.id == id}
  end

  def find_by_name(name)
    merchants.find { |merchant| merchant.name.downcase == name.downcase }
  end

  def find_all_by_name(name)
    merchants.find_all do |merchant|
      merchant.name.downcase.include?(name.downcase)
    end
  end

  def items(merchant_id)
    merchants.map { |merchant| merchant.id == merchant_id }
  end
end

require_relative "./lib/merchant"
require_relative "./lib/sales_engine"

class MerchantRepo
  attr_reader :merchants,
              :parent

  def initialize(parent, filename)
    @merchants    = []
    @sales_engine = parent
    load_file(filename)
  end

  def load_file(filename)
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
end

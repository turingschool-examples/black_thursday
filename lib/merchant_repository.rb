require 'csv'
require_relative 'merchant'

# This is the merchant repository class
class MerchantRepository
  attr_reader :merchant_csv_path, :parent
  def initialize(merchant_csv_path, parent)
    @merchant_csv_path = merchant_csv_path
    @parent            = parent
    @merchants         = []
    csv = CSV.open(merchant_csv_path, headers: true, header_converters: :symbol)
    csv.each do |row|
      @merchants << Merchant.new(row, self)
    end
  end

  def all
    @merchants
  end

  def find_by_id(id)
    @merchants.find { |merchant| merchant.id == id }
  end

  def find_by_name(name)
    @merchants.find { |merchant| merchant.name.casecmp(name.downcase).zero? }
  end

  def find_all_by_name(name)
    @merchants.find_all do |merchant|
      merchant.name.downcase.include?(name.downcase)
    end
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end
end

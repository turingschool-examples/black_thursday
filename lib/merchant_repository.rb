require 'csv'
require_relative 'merchant'

class MerchantRepository
  attr_reader :merchant_csv_path, :parent
  def initialize(merchant_csv_path, parent)
    @merchant_csv_path = merchant_csv_path
    @parent            = parent
  end

  def all
    merchants = []
    contents = CSV.open @merchant_csv_path, headers: true
    contents.each do |row|
      merchants << Merchant.new(id: row[0], name: row[1])
    end
    merchants
  end

  def find_by_id(id)
    all.find { |merchant| merchant.id == id }
  end

  def find_by_name(name)
    all.find { |merchant| merchant.name.downcase == name.downcase }
  end

  def find_all_by_name(name)
    all.find_all do |merchant|
      merchant.name.downcase.include?(name.downcase)
    end
  end
end

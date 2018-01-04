require './lib/merchant'
require 'csv'

class MerchantRepository

  attr_reader :merchants

  def initialize(csv_file, se)
    @merchants_csv = CSV.open csv_file, headers: true, header_converters: :symbol
    @merchants = []
    @merchants_csv.each do |row|
      id          = row[:id]
      name        = row[:name]
      @merchants << Merchant.new({
        name: name,
        id: id
        })
    end
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

end

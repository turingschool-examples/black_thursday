require "csv"
require "./lib/merchant"

class MerchantRepository
  attr_reader :filename,
              :merchants
  def initialize(filename)
    @filename = filename
    @merchants = Array.new
    generate_merchants(filename)
  end

  def generate_merchants(filename)
    merchants = CSV.open filename, headers: true, header_converters: :symbol
    merchants.each do |row|
      @merchants << Merchant.new(row[:id], row[:name])
    end
  end

  def all
    @merchants
  end

  def find_by_id(id)
     id_found = merchants.find_all do |merchant|
      merchant.id == id
    end
    if id_found.empty?
      return nil
    else
      id_found
    end
  end

  def find_by_name(name)
    name_found = merchants.find do |merchant|
      merchant.name.downcase == name.downcase
    end
  end

  def find_all_by_name(name)
    found_merchants = []
    merchants.find do |merchant|
      found_merchants << merchant if merchant.name.downcase == name.downcase
    end
    found_merchants
  end

  def create(name)
    @merchants << Merchant.new(highest_merchant_id_plus_one, name)
  end

  def update(id, attributes)
  end

  def delete(id)
  end
end

# repo = MerchantRepository.new("./data/merchants.csv")

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
    merchants.find_all do |merchant|
      merchant[:id] == id
    end
  end

  def find_by_name(name)
    merchants.find do |merchant|
      merchant[:name].downcase == name.downcase
    end
  end

  def find_all_by_name(name)
    found_merchants = merchants.find do |merchant|
      merchant[:name].downcase == name.downcase
    end
  end

  def create(attributes)
  end

  def update(id, attributes)
  end

  def delete(id)
  end
end

# repo = MerchantRepository.new("./data/merchants.csv")

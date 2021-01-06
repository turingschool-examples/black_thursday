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
     id_found = merchants.find do |merchant|
      merchant.id == id
    end
  end

  def find_by_name(name)
    name_found = merchants.find do |merchant|
      merchant.name.downcase == name.downcase
    end
  end

  def find_all_by_name(name)
    found_merchants = merchants.find_all do |merchant|
      merchant.name.downcase.include?(name.downcase)
    end
  end

  def highest_merchant_id_plus_one
    highest = @merchants.max do |merchant|
      merchant.id
    end
    highest.id + 1
  end

  def create(hash)
    new_merchant = Merchant.new(highest_merchant_id_plus_one, hash[:name])
    @merchants << new_merchant
    new_merchant
  end

  def update(id, name_hash)
    update_merchant = find_by_id(id)
    update_merchant.update(name_hash[:name]) if !name_hash[:name].nil?
  end

  def delete(id)
    delete = find_by_id(id)
    @merchants.delete(delete)
  end
end

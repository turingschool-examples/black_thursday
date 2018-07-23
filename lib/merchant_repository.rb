require_relative '../lib/merchant'
require 'csv'
require 'pry'

class MerchantRepository

  attr_reader :merchants

  def initialize(merchants_location)
      @merchants_location = merchants_location
      @merchants = []
      load_csv
  end

  def load_csv
    CSV.foreach(@merchants_location, headers: true, header_converters: :symbol) do |row|
      @merchants << Merchant.new(row)
    end
  end

  def all
    @merchants
  end

  def find_by_id(search_id)
    @merchants.find do |merchant|
      search_id == merchant.id
    end
  end

  def find_by_name(name)
    @merchants.find do |merchant|
      name.upcase == merchant.name.upcase
    end
  end

  def find_all_by_name(name)
    @merchants.find_all do |merchant|
      merchant.name.upcase.include?(name.upcase)
    end
  end

  def find_max_id
    max_id_merchant = @merchants.max_by do |merchant|
      merchant.id
    end
    max_id_merchant.id
  end

  def create(attributes)
    merchant = Merchant.new(attributes)
    merchant.created_at = Time.now
    merchant.id = find_max_id + 1
    @merchants << merchant
  end

  def update(id, attributes)
    if find_by_id(id)
      merchant = find_by_id(id)
      merchant.name = attributes[:name]
      merchant.updated_at = Time.now
    end
  end

  def delete(id)
    merchant = find_by_id(id)
    @merchants.delete(merchant)
  end

  def inspect
     "#<#{self.class} #{@merchants.size} rows>"
  end
end

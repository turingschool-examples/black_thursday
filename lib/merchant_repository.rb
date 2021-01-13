require_relative "merchant"
require_relative 'repository_module'
require "csv"

class MerchantRepository
  include Repository
  attr_reader :filename,
              :collection,
              :parent

  def initialize(filename, parent)
    @filename = filename
    @parent = parent
    @collection = Array.new
    generate_merchants(filename)
  end

  def generate_merchants(filename)
    merchants = CSV.open filename, headers: true, header_converters: :symbol
    merchants.each do |row|
      @collection << Merchant.new(row[:id], row[:name], self)
    end
  end

  def find_all_by_name(name)
    found_merchants = collection.find_all do |merchant|
      merchant.name.downcase.include?(name.downcase)
    end
  end

  def create(hash)
    new_merchant = Merchant.new(highest_id_plus_one, hash[:name], self)
    @collection << new_merchant
    new_merchant
  end

  def update(id, name_hash)
    update_merchant = find_by_id(id)
    update_merchant.update(name_hash[:name]) if !name_hash[:name].nil?
  end

  # def delete(id)
  #   delete = find_by_id(id)
  #   @collection.delete(delete)
  # end

  # def inspect
  # "#<#{self.class} #{@collection.size} rows>"
  # end
end

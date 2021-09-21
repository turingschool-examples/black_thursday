require_relative 'merchant'
require 'csv'

class MerchantsRepository
  attr_reader :all

  def initialize(merchant_array)
    @all = merchant_creator(merchant_array)
  end

  def merchant_creator(merchant_array)
    merch_array = []
    merch_table = CSV.read(merchant_array, headers: true)
    merch_table.each do |row|
      merch_hash = {}
      row_headers = row.headers
      merch_hash[row_headers[0].to_sym] = row[0]
      merch_hash[row_headers[1].to_sym] = row[1]
      merch_array.push(Merchant.new(merch_hash))
    end
    merch_array
  end

  def find_by_id(id)
    @all.find { |merchant| merchant.id.to_i == id }
  end

  def find_by_name(name)
    @all.find { |merchant| merchant.name.casecmp?(name) }
  end

  def find_all_by_name(name)
    @all.find_all { |merchant| merchant.name.upcase.include? name.upcase }
  end

  def create(attributes)
    new_id = max_merchant.id.to_i + 1
    new_merch_hash = {}
    attributes.each do |key, value|
      new_merch_hash[key] = value
    end
    new_merch_hash[:id] = new_id
    all << Merchant.new(new_merch_hash)
  end

  def max_merchant
    @all.max { |merch1, merch2| merch1.id <=> merch2.id }
  end

  def update(id, attributes)
    find_by_id(id).update_info(attributes) unless find_by_id(id).nil?
  end

  def delete(id)
    merch_object = @all.find do |merchant|
      merchant.id.to_i == id
    end
    @all.delete(merch_object)
  end

  def inspect
    "#<#{self.class} #{all.size} rows>"
  end
end

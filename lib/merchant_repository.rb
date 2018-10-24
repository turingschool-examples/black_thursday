require 'csv'
require 'pry'

class MerchantRepository
  attr_reader :merchants_array

  def initialize(file_path)
    @merchants_array = from_csv(file_path)
  end

  def from_csv(file_path)
    raw_merchant_data = CSV.read(file_path, {headers: true, header_converters: :symbol})
    raw_merchant_data.map do |raw_merchant|
      Merchant.new(raw_merchant.to_h)
    end
  end

  def all
    @merchants_array
  end

  def find_by_id(merchant_id)
    @merchants_array.find do |merchant|
      merchant.id == merchant_id
    end
  end

  def find_by_name(merchant_name)
    @merchants_array.find do |merchant|
      merchant.name.downcase == merchant_name.downcase
    end
  end

  def find_all_by_name(merchant_name)
    @merchants_array.find_all do |merchant|
      merchant.name.downcase.include?(merchant_name.downcase)
    end
  end

  def create(attributes)
  highest_merchant = @merchants_array.max {|merchant| merchant.id}
  new_merchant_id = highest_merchant.id + 1
  attributes[:id] = new_merchant_id
  new_merchant = Merchant.new(attributes)
    @merchants_array << new_merchant
  end

  def update(id, attribute)
    merchant = find_by_id(id)
    merchant.name = attribute[:name]
  end

  def delete(id)
    merchant = find_by_id(id)
    @merchants_array.delete(merchant)
  end
end

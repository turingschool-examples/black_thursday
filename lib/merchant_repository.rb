require 'csv'
require './lib/merchant'

# A class for containing all Merchant objects
class MerchantRepository
  attr_reader :merchants

  def initialize(csv_parsed_array)
    @merchants = create_index(csv_parsed_array)
    # @by_name = {}
  end

  def create_index(csv_data)
    csv_data.shift
    merchant_data = {}
    csv_data.each do |merchant|
      merchant_data[merchant[0]] = Merchant.new(merchant[0], merchant[1])
    end
    merchant_data
  end

  def all
    @merchants.values
  end

  def find_by_id(id)
    @merchants[id.to_s]
  end

  def find_by_name(name)
    @merchants.values.each do |merchant|
      return merchant if merchant.name.downcase == name.downcase
    end
  end

  def find_all_by_name(fragment)
    @merchants.values.map do |merchant|
      merchant.name if merchant.name.downcase.include?(fragment.downcase)
    end.compact
  end

  def create_new_id
    highest_id = @merchants.keys.max
    (highest_id.to_i + 1).to_s
  end

  def create(name, id = create_new_id)
    @merchants[id] = Merchant.new(id, name)
  end

  def update(id, new_name)
    @merchants[id].name = new_name
  end

  def delete(id)
    @merchants.delete(id)
  end
end

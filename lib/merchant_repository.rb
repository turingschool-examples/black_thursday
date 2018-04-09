require './lib/merchant'

# A class for containing all Merchant objects
class MerchantRepository
  attr_reader :merchants

  def initialize(csv_parsed_array)
    csv_parsed_array.shift
    attributes = csv_parsed_array.map do |merchant|
      { id: merchant[0], name: merchant[1] }
    end
    @merchants = create_index(attributes)
  end

  def create_index(attributes)
    merchant_data = {}

    attributes.each do |attribute_set|
      merchant_data[attribute_set[:id]] = Merchant.new(attribute_set)
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
      merchant if merchant.name.downcase.include?(fragment.downcase)
    end.compact
  end

  def create_new_id
    highest_id = @merchants.keys.max
    (highest_id.to_i + 1).to_s
  end

  def create(attributes)
    attributes[:id] = create_new_id
    @merchants[attributes[:id]] = Merchant.new(attributes)
  end

  def update(id, attributes)
    @merchants[id].name = attributes[:name]
  end

  def delete(id)
    @merchants.delete(id)
  end
end

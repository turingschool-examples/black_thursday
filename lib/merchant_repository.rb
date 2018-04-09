require_relative '../lib/merchant'
require_relative 'repository'

# A class for containing all Merchant objects
class MerchantRepository < Repository
  attr_reader :merchants

  def initialize(csv_parsed_array)
    csv_parsed_array.shift
    attributes = csv_parsed_array.map do |merchant|
      { id: merchant[0].to_i, name: merchant[1] }
    end
    @merchants = create_index(Merchant, attributes)
    super(merchants)
  end
  
  def find_by_id(id)
    @merchants[id]
  end

  def find_by_name(name)
    result = nil
    @merchants.values.each do |merchant|
      result = merchant if merchant.name.casecmp(name).zero?
    end
    result
  end

  def find_all_by_name(fragment)
    @merchants.values.map do |merchant|
      merchant if merchant.name.downcase.include?(fragment.downcase)
    end.compact
  end

  def create_new_id
    highest_id = @merchants.keys.max
    (highest_id.to_i + 1)
  end

  def create(attributes)
    attributes[:id] = create_new_id
    @merchants[attributes[:id]] = Merchant.new(attributes)
  end

  def update(id, attributes)
    @merchants[id].name = attributes[:name] if @merchants[id]
  end

  def delete(id)
    @merchants.delete(id)
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end
end

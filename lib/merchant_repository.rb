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
    super(merchants, Merchant)
  end

  def update(id, attributes)
    @merchants[id].name = attributes[:name] if @merchants[id]
  end
end

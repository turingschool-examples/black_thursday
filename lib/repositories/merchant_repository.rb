require_relative '../elementals/merchant'
require_relative 'repository'

# A class for containing all Merchant objects
class MerchantRepository < Repository
  attr_reader :merchants

  def initialize(merchants_data)
    @merchants = create_index(Merchant, merchants_data)
    super(merchants, Merchant)
  end

  def update(id, attributes)
    @merchants[id].name = attributes[:name] if @merchants[id]
  end
end

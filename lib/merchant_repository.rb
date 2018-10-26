require_relative '../lib/merchant'
require_relative './find_methods'
require 'csv'

class MerchantRepository
  include FindMethods
  def initialize(data)
    @collection = data
  end

  def create(attribute)
    highest = @collection.max_by do |merchant|
      merchant.id
    end
    number = highest.id + 1
    new_merchant = Merchant.new({ id: number, name: attribute[:name] })
    @collection << new_merchant
    new_merchant
  end

  def update(id, data)
    if find_by_id(id) == nil
    else
      find_by_id(id).name = data[:name]
    end
  end
end

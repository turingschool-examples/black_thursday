require_relative './data_repository'
require_relative './merchant'

class MerchantRepository < DataRepository
  def initialize(data)
    populate(data, Merchant)
  end

  def merchants
    return @data_set.values
  end
end

require_relative 'merchant_repo'
require_relative 'item_repo'
require 'csv'

class SalesEngine
  include MerchantRepository
  include ItemRepository

end

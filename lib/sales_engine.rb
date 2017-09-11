require_relative 'merchant_repo'
require_relative 'item_repo'
require 'csv'

class SalesEngine
  include MerchantRepository
  include ItemRepository

  def open_csv
    

  end

end

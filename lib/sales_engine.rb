require_relative '../lib/item'
require_relative '../lib/merchant'
require_relative '../lib/merchant_repository'
require_relative '../lib/item_repository'
require 'CSV'

class SalesEngine

  # def initialize(items_data_file, merchants_data_file)
  #   @items = ItemRepository.new(items_data_file)
  #   @merchants = MerchantRepository.new(merchants_data_file)
  # end
  #
  def initialize(data_hash)
    require 'pry'; binding.pry
    @merchants = MerchantRepository.new(data_hash[:merchants])
  end

  def self.from_csv(data_hash)
    SalesEngine.new(data_hash)
  end

end

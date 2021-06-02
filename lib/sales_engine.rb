require 'CSV'
require_relative 'merchant_repository'
require_relative 'item_repository'

class SalesEngine
  attr_reader :items, :merchants

  def initialize(file_location)
    # @merchants = Merchants.new(file_location[:merchant], self)
    @item_repository = ItemRepository.new(file_location[:items], self).create_repo
    @merchant_repository = MerchantRepository.new(file_location[:merchants], self).create_repo
  end

  def self.from_csv(file_location)
    SalesEngine.new(file_location)
  end

  def merchants
    @merchant_repository
  end

  def find_merchant_by_id(id)
    @merchant_repository.find_by_id(id)
  end

  def items
    @item_repository
  end

  def find_item_by_id(id)
    @item_repository.find_by_id(id)
  end



end

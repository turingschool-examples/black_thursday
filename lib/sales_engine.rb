require 'csv'
require_relative 'merchant_repository'
require_relative 'item_repository'

class SalesEngine
  attr_reader :files, :merchants, :items

  def initialize(files)
    @files = files
    @merchants = MerchantRepository.new(files[:merchants], self)
    @items = ItemRepository.new(files[:items], self)
  end

  def self.from_csv(files)
    new(files)
  end

  def items_by_merchant_id(merchant_id)
    @items.find_all_by_merchant_id(merchant_id)
  end

  def merchant_by_merchant_id(merchant_id)
    @merchants.find_by_id(merchant_id)
  end

  # def average_items_by_merchant
  #   mr = @merchants.all
  #   ir = @items.all
  #
  #   (ir.length)/(mr.length)
  # end
end

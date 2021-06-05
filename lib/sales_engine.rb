require_relative 'item_repository'
require_relative 'merchant_repository'
require_relative 'transaction_repository'
require 'csv'

class SalesEngine
  def initialize(path)
    @items = path[:items]
    @merchants = path[:merchants]
    @transactions = TransactionRepository.new(path[:transactions])
  end

  def self.from_csv(path)
    SalesEngine.new(path)
  end

  def items
    ItemRepository.new(@items)
  end

  def merchants
    MerchantRepository.new(@merchants)
  end

  # def analyst
  #   SalesAnalyst.new
  # end

end

require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'invoice_repository'
require_relative 'invoice_item_repository'
require_relative 'transaction_repository'
require_relative 'customer_repository'
require 'bigdecimal'
require 'csv'

class SalesEngine

  attr_reader :files, :merchant_repo, :item_repo

  def initialize(files)
    @files = files
    @merchant_repo = nil
    @item_repo = nil
  end

  def self.from_csv(files)
    SalesEngine.new(files)
  end

  def merchants
    if @merchant_repo != nil
      @merchant_repo
    else
      @merchant_repo = MerchantRepository.new(files[:merchants], self)
      @merchant_repo.load_csv_data
      @merchant_repo
    end
  end

  def items
    if @item_repo != nil
      @item_repo
    else
      @item_repo = ItemRepository.new(files[:items], self)
      @item_repo.load_csv_data
      @item_repo
    end
  end

end

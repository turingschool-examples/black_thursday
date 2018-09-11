require 'time'
require 'bigdecimal'
require_relative '../lib/sales_engine'
require_relative '../lib/csv_adaptor'
require_relative '../lib/merchant'
require_relative '../lib/merchant_repo'
require_relative '../lib/item'
require_relative '../lib/item_repo'

class SalesEngine < CsvAdaptor

  attr_reader :item_file,
              :merchant_file

  def self.from_csv(file_hash)
    item_file = file_hash[:items]
    merchant_file = file_hash[:merchants]
      SalesEngine.new(item_file, merchant_file)
  end

  def initialize(item_file, merchant_file)
    @item_file = item_file
    @merchant_file = merchant_file
  end

  def merchants
    MerchantRepo.new(@merchant_file)
  end

  def items
    ItemRepo.new(@item_file)
  end

  def analyst
    SalesAnalyst.new(@item_file, @merchant_file)
  end

end

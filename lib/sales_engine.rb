require 'pry'
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
              :merchant_file,
              :mr,
              :ir

  def self.from_csv(file_hash)
    item_file = file_hash[:items]
    merchant_file = file_hash[:merchants]
      s = SalesEngine.new(item_file, merchant_file)
  end

  def initialize(item_file, merchant_file)
    @item_file = item_file
    @merchant_file = merchant_file
    @mr = MerchantRepo.new(merchant_file)
    mr.merchant_array_from_file
    @ir = ItemRepo.new(item_file)
    ir.item_array_from_file
  end

  def merchant_array_from_file
    merchant_array = []
    load_merchants(merchant_file).each do |merchant_info|
      merchant_array << Merchant.new(merchant_info)
    end
    merchant_array
  end

  def item_array_from_file
    item_array = []
    load_items(item_file).each do |item_info|
      item_array << Item.new(item_info)
    end
    item_array
  end

  def merchants
    mr
  end

  def items
    ir
  end

  def analyst
    SalesAnalyst.new(@item_file, @merchant_file)
  end

end

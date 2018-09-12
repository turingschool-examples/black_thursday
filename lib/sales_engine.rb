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
              :merchant_file

  def self.from_csv(file_hash)
    item_file = file_hash[:items]
    merchant_file = file_hash[:merchants]
      s = SalesEngine.new(item_file, merchant_file)
  end

  def initialize(item_file, merchant_file)
    @item_file = item_file
    @merchant_file = merchant_file
  end

  def merchants
    m = MerchantRepo.new(@merchant_file)
    load_merchants(merchant_file).each do |merchant_info|
      m.merchants << Merchant.new(merchant_info)
    end
    m
  end

  def items
    i = ItemRepo.new(@item_file)
    i.load_items(item_file).each do |item_info|
      i.items << Item.new(item_info)
    end
    i
  end

  def analyst
    SalesAnalyst.new(@item_file, @merchant_file)
  end

end

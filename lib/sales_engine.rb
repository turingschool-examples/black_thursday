# frozen_string_literal: true

require 'csv'

require_relative './item'
require_relative './item_repository'
require_relative './merchant'
require_relative './merchant_repository'
require_relative './sales_analyst'
require_relative './invoice_item_repository'

# ./lib/sales_engine
class SalesEngine
  attr_accessor :merchant_repository,
                :item_repository,
                :invoice_item_repository

  def initialize
    @merchant_repository = nil
    @item_repository = nil
    @invoice_item_repository = nil
  end

  def self.from_csv(data)
    sales_engine = SalesEngine.new
    sales_engine.merchant_repository = sales_engine.merchant_builder(data[:merchants])
    sales_engine.item_repository = sales_engine.item_builder(data[:items])
    sales_engine.invoice_item_repository = sales_engine.invoice_item_builder(data[:invoice_items])
    sales_engine
  end

  def merchants
    @merchant_repository
  end

  def items
    @item_repository
  end

  def invoice_items
    @invoice_item_repository
  end

  def csv_reader(csv)
    array = []
    CSV.foreach(csv) do |row|
      array << row
    end
    array.delete_at(0)
    array
  end

  def merchant_builder(merchant_data)
    merchant_repository = MerchantRepository.new
    merchant_array = csv_reader(merchant_data)
    merchant_array.each do |merchant|
      merchant_repository.create_with_id(id: merchant[0], name: merchant[1])
    end
    merchant_repository
  end

  def item_builder(item_data)
    item_repository = ItemRepository.new
    array = csv_reader(item_data)
    array.each do |item|
      item_repository.create_with_id(id: item[0],
                                     name: item[1],
                                     description: item[2],
                                     unit_price: item[3],
                                     merchant_id: item[4],
                                     created_at: item[5],
                                     updated_at: item[6])
    end
    item_repository
  end

  def invoice_item_builder(item_data)
    invoice_item_repository = InvoiceItemRepository.new
    array = csv_reader(item_data)
    array.each do |invoice|
      invoice_item_repository.create_with_id(id: invoice[0].to_i,
                                             item_id: invoice[1],
                                             invoice_id: invoice[2],
                                             quantity: invoice[3],
                                             unit_price: invoice[4],
                                             created_at: invoice[5],
                                             updated_at: invoice[6])
    end
    invoice_item_repository
  end

  def analyst
    SalesAnalyst.new(@merchant_repository, @item_repository)
  end

end

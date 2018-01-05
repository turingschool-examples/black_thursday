require_relative '../lib/item_repository'
require_relative '../lib/merchant_repository'
require 'pry'

class SalesEngine

  attr_reader :item_repository,
              :merchant_repository

  def initialize(csv_files)
    @item_repository = ItemRepository.new(csv_files[:items], self)
    @merchant_repository = MerchantRepository.new(csv_files[:merchants], self)
  end

  def self.from_csv(csv_files)
    SalesEngine.new(csv_files)
  end

  def find_item_by_merchant_id(id)
    item_repository.find_item(id)
  end

  def find_merchant_by_id(id)
    merchant_repository.find_merchant(id)
  end

  def grab_total_amount_of_items
    item_repository.total_items
  end

  def grab_total_amount_of_merchants
    merchant_repository.total_merchants
  end

  def grab_array_of_merchant_items
    merchant_repository.grab_array_of_items
  end

  def grab_merchants_with_high_items(sales_analyst)
    merchant_repository.grab_merchants(sales_analyst)
  end

  def grab_all_merchants
    merchant_repository.create_merchant_list
  end

end

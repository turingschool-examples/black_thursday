require_relative '../lib/item_repository'
require_relative '../lib/merchant_repository'
require 'pry'

class SalesEngine

  attr_reader :items,
              :merchants

  def initialize(csv_files)
    @items = ItemRepository.new(csv_files[:items], self)
    @merchants = MerchantRepository.new(csv_files[:merchants], self)
  end

  def self.from_csv(csv_files)
    SalesEngine.new(csv_files)
  end

  def find_item_by_merchant_id(id) # NEEDS TESTS
    item_repository.find_item(id)
  end

  def find_merchant_by_id(id) # NEEDS TESTS
    merchant_repository.find_merchant(id)
  end

  def grab_total_amount_of_items # NEEDS TESTS
    item_repository.total_items
  end

  def grab_total_amount_of_merchants # NEEDS TESTS
    merchant_repository.total_merchants
  end

  def grab_array_of_merchant_items # NEEDS TESTS
    merchant_repository.grab_array_of_items
  end

  def grab_merchants_with_high_items(sales_analyst) # NEEDS TESTS
    merchant_repository.grab_merchants(sales_analyst)
  end

  def grab_all_merchants # NEEDS TESTS
    merchant_repository.create_merchant_list
  end

  def grab_all_items # NEEDS TESTS
    item_repository.create_item_list
  end

end

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
    items.find_item(id)
  end

  def find_merchant_by_id(id) # NEEDS TESTS
    merchants.find_merchant(id)
  end

  def grab_total_amount_of_items # NEEDS TESTS
    items.total_items
  end

  def grab_total_amount_of_merchants # NEEDS TESTS
    merchants.total_merchants
  end

  def grab_array_of_merchant_items # NEEDS TESTS
    merchants.grab_array_of_items
  end

  def grab_merchants_with_high_items(sales_analyst) # NEEDS TESTS
    merchants.grab_merchants(sales_analyst)
  end

  def grab_all_merchants # NEEDS TESTS
    merchants.create_merchant_list
  end

  def grab_all_items # NEEDS TESTS
    items.create_item_list
  end

end

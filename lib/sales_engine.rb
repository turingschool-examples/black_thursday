require './lib/merchant_repository'
require './lib/item_repository'

class SalesEngine

  attr_accessor :merchant_csv_filepath, :item_csv_filepath

  def self.from_csv(info)
    se = SalesEngine.new
    se.merchant_csv_filepath = info[:merchants]
    se.item_csv_filepath = info[:items]
    se
  end

  def initialize
    @merchant_csv_filepath = ''
    @item_csv_filepath = ''
  end

  def merchants
    if @merchant_repository.nil?
      @merchant_repository = MerchantRepository.new(@merchant_csv_filepath, self)
    else
      @merchant_repository
    end
  end

  def items
    if @item_repository.nil?
      @item_repository = ItemRepository.new(@item_csv_filepath, self)
    else
      @item_repository
    end
  end

  def total_merchants
    self.merchants.merchants.length
  end

  def total_items
    self.items.items.length
  end

  def average_items_per_merchant
    total_items / total_merchants
  end

  def merchant_item_count
    self.merchants.merchants.map do |merchant|
      merchant.items.count
    end
  end

  def standard_deviation_for_merchant_items
    average_items_per_merchant
    sum_of_squared_differences = merchant_item_count.reduce(0) do |sum, item_count|
      (item_count - average_items_per_merchant) ** 2
    end
    Math.sqrt(sum_of_squared_differences)
  end

end

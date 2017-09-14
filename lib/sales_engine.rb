# require './lib/merchant_repository'
# require './lib/item_repository'
require_relative 'merchant_repository'
require_relative 'item_repository'

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
    total_items / total_merchants.to_f
  end

  def merchant_item_count
    self.merchants.merchants.map do |merchant|
      merchant.items.count
    end
  end

  # def standard_deviation_for_merchant_items
  #   average = average_items_per_merchant
  #
  #   difference_from_average = merchant_item_count.map do |item_count|
  #     item_count - average
  #   end
  #   squared_values = difference_from_average.map {|diff| diff ** 2}
  #
  #   sum_of_squares = squared_values.sum
  #
  #   Math.sqrt(sum_of_squares / (merchant_item_count.count - 1))
  # end

  # def merchants_with_high_item_count
  #   std_dev = standard_deviation_for_merchant_items
  #
  #   self.merchants.merchants.select do |merchant|
  #     merchant.items.count > std_dev
  #   end
  # end
  #
  # def average_item_price_for_merchant(merchant_id)
  #   merchant = self.merchants.find_by_id(merchant_id)
  #   total_item_price = merchant.items.reduce(0) do |total_price, item|
  #     total_price + item.unit_price
  #   end
  #   return total_item_price / merchant.items.count unless total_item_price == 0
  #   return 0
  # end


  # def average_average_price_per_merchant
  #
  #   merchant_price_averages = self.merchants.merchants.map do |merchant|
  #     average_item_price_for_merchant(merchant.id)
  #   end
  #   merchant_price_averages.sum / merchant_price_averages.count
  # end

  # def item_standard_deviation
  #   total_item_price = self.items.items.reduce(0) do |total_price, item|
  #     total_price + item.unit_price
  #   end
  #   average_item_price = total_item_price / total_items.to_f
  #
  #   item_price_differences = self.items.items.map do |item|
  #     (item.unit_price - average_item_price) ** 2
  #   end
  #
  #   sum_of_squares = item_price_differences.sum
  #
  #   Math.sqrt(sum_of_squares / (total_items - 1))
  # end
  # 
  # def golden_items
  #   std_dev = item_standard_deviation
  #   self.items.items.select do |item|
  #     item.unit_price >  std_dev * 2
  #   end
  # end

end

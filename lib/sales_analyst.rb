require 'item_repo'
require 'merchant_repo'


class SalesAnalyst

  include Math

  def initialize(engine)
    @engine = engine
  end

  def average_items_per_merchant
    merchant = @engine.merchants.all
    items    = @engine.items.all
    average = (items.length.to_f)/(merchant.length)
    average.round(2)
  end

   def average_items_per_merchant_standard_deviation
     mean = average_items_per_merchant
     subtract_mean = return_array_of_items_by_merchant.map do |merchant_items|
       merchant_items - mean
     end
     subtract_mean.map! do |num|
       num ** 2
     end
     subtract_mean = subtract_mean.reduce(:+)
     subtract_mean = subtract_mean/(return_array_of_items_by_merchant.length - 1)
     Math.sqrt(subtract_mean).round(2)
   end

   def return_array_of_items_by_merchant
     @engine.merchants.all.map do |merchant|
       @engine.find_items_by_merchant_id(merchant.id).length
     end
   end

  def merchants_with_high_item_count
    # Which merchants sell the most items?
    # Maybe we could set a good example for our lower sellers by displaying the merchants who have the most items for sale.
    # Which merchants are more than one standard deviation above the average number of products offered?
    # it "#merchants_with_high_item_count returns merchants more than one standard deviation above the average number of products offered" do
    #   expected = sales_analyst.merchants_with_high_item_count
    #
    #   expect(expected.length).to eq 52
    #   expect(expected.first.class).to eq Merchant
    # end
  end

  def average_item_price_for_merchant(merchant_id)
    merchant = @engine.merchants.find_by_id(merchant_id)
    total_price = merchant.items.reduce(0) do |sum, item|
      sum + item.unit_price
    end
    return 0 if merchant.items.empty?
    (total_price / merchant.items.count).round(2)
  end

  def average_average_price_per_merchant
    total_average = @engine.merchants.all.reduce(0) do |sum, merchant|
      sum + average_item_price_for_merchant(merchant.id)
    end
    (total_average / @engine.merchants.all.count).round(2)
  end

  def golden_items
    # Given that our platform is going to charge merchants based on their sales, expensive items are extra exciting to us. Which are our “Golden Items”,
    # those two standard-deviations above the average item price? Return the item objects of these “Golden Items”.
    # it "#golden_items returns items that are two standard deviations above the average price" do
    #   expected = sales_analyst.golden_items
    #
    #   expect(expected.length).to eq 5
    #   expect(expected.first.class).to eq Item
    # end
  end

end

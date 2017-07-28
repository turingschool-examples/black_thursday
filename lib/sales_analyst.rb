require 'item_repo'
require 'merchant_repo'

class SalesAnalyst

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
     #  it "#average_items_per_merchant_standard_deviation returns the standard deviation" do
     #   expected = sales_analyst.average_items_per_merchant_standard_deviation
     #
     #   expect(expected).to eq 3.26
     #   expect(expected.class).to eq Float
     # end
     # Note on Standard Deviations
     #
     # There are two ways for calculating standard deviations – for a population and for a sample.
     #
     # For this project, use the sample standard deviation.
     #
     # As an example, given the set 3,4,5. We would calculate the deviation using the following steps:
     #
     # Take the difference between each number and the mean and square it
     # Sum these square differences together
     # Divide the sum by the number of elements minus 1
     # Take the square root of this result
     # Or, in pseudocode:
     #
     # set = [3,4,5]
     #
     # std_dev = sqrt( ( (3-4)^2+(4-4)^2+(5-4)^2 ) / 2 )
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
    # Then we can sum all of the averages and find the average price across all merchants
    #(this implies that each merchant’s average has equal weight in the calculation)
    # it "#average_average_price_per_merchant returns the average price for all merchants" do
    #   expected = sales_analyst.average_average_price_per_merchant
    #
    #   expect(expected).to eq 350.29
    #   expect(expected.class).to eq BigDecimal
    # end
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

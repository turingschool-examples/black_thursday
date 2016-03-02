require_relative 'sales_engine'
require 'csv'
require 'pry'

class SalesAnalyst
  def initialize(se)
    @se = se
  end

  def average_items_per_merchant
    @average_items_per_merchant = (@se.items.repository.count.to_f/@se.merchants.repository.count.to_f).round(2)
  end

  def items_per_merchant_hash #need test?
    @se.items.repository.group_by { |item| item.merchant_id }
  end

  def item_count_per_merchant_hash # need test?
    items_per_merchant_hash.map { |merchant_id, items| [merchant_id, items.count] }.to_h
  end

  def average_items_per_merchant_standard_deviation
    n = item_count_per_merchant_hash.values.map do |value|
          (value - average_items_per_merchant)**2
        end.reduce(:+)/(@se.merchants.repository.count.to_f - 1)

    @std_dev = Math.sqrt(n).round(2)
  end

  def merchants_with_high_item_count # >= 1 std_dev or > 1 std_dev?
    # display as an array merchants who have the most items for sale
    # eligibility determined by std_dev > 1 above the average number of products offered; so want merchants with items numbering >= 9.40 = 3.26 (2 std_dev)+ 2.88(avg. items per merchant)
    # more than 1 std_dev meaning > 6.14
    one_std_dev = @std_dev + @average_items_per_merchant

    merchants_with_high_item_count = item_count_per_merchant_hash.find_all do |merchant_id, item_count|
                                        merchant_id if item_count > one_std_dev
                                      end.map do |element|
                                        @se.merchants.find_by_id(element[0])
                                      end
  end

end

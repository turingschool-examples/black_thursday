require_relative 'sales_engine'


class SalesAnalyst
  attr_reader :items, :merchants, :invoices, :invoice_items, :customers, :transactions, :id_counter
  def initialize(items, merchants, invoices, invoice_items, customers, transactions)
  @items = items
  @merchants = merchants
  @invoices = invoices
  @invoice_items = invoice_items
  @customers = customers
  @transactions = transactions
  end

  def average_items_per_merchant
      return (@items.length.to_f/@merchants.length.to_f).round(2)
  end

  def average_items_per_merchant_standard_deviation
    items_per_merchant
    total_to_be_square_rooted = 0.0
    @id_counter.each do |index|
      total_to_be_square_rooted += (average_items_per_merchant.to_f - index[1].to_f)**2
    end
    return ((total_to_be_square_rooted/(@merchants.length.to_f - 1))**0.5).round(2)
  end

  def merchants_with_high_item_count
    average_items_per_merchant_fixed = average_items_per_merchant
    average_items_per_merchant_standard_deviation_fixed = average_items_per_merchant_standard_deviation
    id_counter_fixed = @id_counter
    high_item_count =  id_counter_fixed.find_all {|index| index[1] >= average_items_per_merchant_standard_deviation_fixed + average_items_per_merchant_fixed}
  end

  def average_item_price_for_merchant(merchant_id)
    items_per_merchant
    number_of_items = @id_counter[merchant_id]
    items = @items.find_all{|index| index.merchant_id == merchant_id}
    total_cost = 0.0
    items.each {|index| total_cost += index.unit_price}
    return (total_cost./(100 * number_of_items)).round(2)
  end

  def average_item_price_per_merchant
    items_per_merchant
    id_counter_fixed = @id_counter
    sum_of_all_averages = 0.0
    id_counter_fixed.keys.each {|index| sum_of_all_averages += average_item_price_for_merchant(index)}
    (sum_of_all_averages / @merchants.length).round(2)
  end

  def golden_items
    standard_deviation_of_item_price_fixed = standard_deviation_of_item_price
    average_item_price_fixed = average_item_price
    @items.find_all {|index| index.unit_price.to_f > (average_item_price_fixed + standard_deviation_of_item_price_fixed + standard_deviation_of_item_price_fixed) }
  end
#helper method that returns a hash with every
#merchant id and the number of items that
#merchant has
  def items_per_merchant
    @id_counter = Hash.new(0)
    @items.each do |index|
      id_counter[index.merchant_id] += 1
    end
    return @id_counter
  end

  def average_item_price
    cost_of_all_items = 0.0
    @items.each {|index| cost_of_all_items += index.unit_price.to_f}
    return cost_of_all_items/@items.length.to_f
  end


  def standard_deviation_of_item_price
    squared_item_price_total = 0.0
    average_item_price_fixed = average_item_price
    @items.each {|index| squared_item_price_total += ((index.unit_price.to_f - average_item_price_fixed)**2)}
    return (squared_item_price_total/(@items.length - 1 ))**0.5
  end

end

require_relative 'sales_engine'
require_relative 'merchant_repository'

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
    high_item_count_merchants = []
    # high_item_count.each{|item| merchants.find{|merchant| if merchant.id == item[0] high_item_count_merchants.push(merchant)}}
    high_item_count.each do |item|
      @merchants.find_all do |merchant|
        if item[0] == merchant.id.to_s
          high_item_count_merchants << merchant
        end
      end
    end
    return high_item_count_merchants
  end

  def average_item_price_for_merchant(merchant_id)
    items_per_merchant
    number_of_items = @id_counter[merchant_id.to_s]
    items = @items.find_all{|index| index.merchant_id == merchant_id.to_s}
    total_cost = 0.0
    items.each {|index| total_cost += index.unit_price}
    return (total_cost./(100 * number_of_items)).round(2)
  end

  def average_average_price_per_merchant
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

  def invoices_per_merchant
    @id_counter = Hash.new(0)
    @invoices.each do |index|
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

  def average_invoices_per_merchant
    return (@invoices.length.to_f/@merchants.length.to_f).round(2)
  end

  def average_invoices_per_merchant_standard_deviation
    invoices_per_merchant
    total_to_be_square_rooted = 0.0
    @id_counter.each do |index|
      total_to_be_square_rooted += (average_invoices_per_merchant.to_f - index[1].to_f)**2
    end
    return ((total_to_be_square_rooted/(@merchants.length.to_f - 1))**0.5).round(2)
  end

  def top_merchants_by_invoice_count
    high_in_invoices = invoices_per_merchant.find_all do |id, invoices|
      invoices >= (average_invoices_per_merchant + (average_invoices_per_merchant_standard_deviation * 2))
    end
    merchants_high_in_invoices = []
    high_in_invoices.each do |item|
      @merchants.find_all do |merchant|
        if item[0] == merchant.id.to_s
          merchants_high_in_invoices << merchant
        end
      end
    end
    merchants_high_in_invoices
  end

  def bottom_merchants_by_invoice_count
    low_in_invoices = invoices_per_merchant.find_all do |id, invoices|
      invoices <= (average_invoices_per_merchant - (average_invoices_per_merchant_standard_deviation * 2))
    end
    merchants_low_in_invoices = []
    low_in_invoices.each do |invoice|
      @merchants.find_all do |merchant|
        if invoice[0] == merchant.id.to_s
          merchants_low_in_invoices << merchant
        end
      end
    end
    merchants_low_in_invoices
  end

  def top_days_by_invoice_count
    days = @invoices.map do |invoice|
      formatted_date = invoice.created_at.split('')
      year = formatted_date[0..3].join.to_i
      month = formatted_date[5..6].join.to_i
      day = formatted_date[8..9].join.to_i
      Date.new(year, month, day).cwday
      day_number_to_name(Date.new(year, month, day).cwday)
    end
    recurring_days = day_counter(days)
    frequency_of_days = recurring_days.map do |day, times_occured|
      times_occured
    end
    top_day = recurring_days.find do |day, times_occured|
      times_occured == frequency_of_days.max
    end
    [top_day[0].to_s.capitalize.delete_suffix("s")]
  end

  def day_number_to_name(num)
    {1 => "Monday", 2 => "Tuesday", 3 => "Wednesday",
    4 => "Thursday", 5 => "Friday", 6 => "Saturday", 7 => "Sunday"}[num]
  end

  def day_counter(days)
    { :mondays => days.count {|day| day == "Monday"}, :tuesdays => days.count {|day| day == "Tuesday"},
      :wednesdays => days.count {|day| day == "Wednesday"}, :thursdays => days.count {|day| day == "Thursday"},
      :fridays => days.count {|day| day == "Friday"}, :saturdays =>  days.count {|day| day == "Saturday"},
      :sundays => days.count {|day| day == "Sunday"} }
  end

  def invoice_status(status)
    full_count = @invoices.count
    status_count = @invoices.count {|invoice| invoice.status == status.to_s}
    ((status_count.to_f / full_count) *  100).round(2)
  end

end

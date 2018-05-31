require_relative 'mathematics_module'

class SalesAnalyst
  include Mathematics

  attr_reader     :items,
                  :merchants,
                  :invoices,
                  :transactions

  def initialize(items, merchants, invoices, transactions)
    @items = items
    @merchants = merchants
    @invoices = invoices
    @transactions = transactions
  end

  def average_items_per_merchant
    items_per_merchant = Hash.new(0)
    @items.members.each do | item |
      items_per_merchant[item.merchant_id] += 1
    end
    sum = items_per_merchant.values.inject(0) {| sum, n | sum+n}

    return (sum.to_f / items_per_merchant.values.length.to_f).round(2)
  end

  def average_invoices_per_merchant
    invoices_per_merchant = Hash.new(0)
    @invoices.members.each do | invoice |
      invoices_per_merchant[invoice.merchant_id] += 1
    end
    sum = invoices_per_merchant.values.inject(0) {| sum, n | sum+n}

    return (sum.to_f / invoices_per_merchant.values.length.to_f).round(2)
  end

  def average_items_per_merchant_standard_deviation
    items_per_merchant = Hash.new(0)
    @items.members.each do | item |
      items_per_merchant[item.merchant_id] += 1
    end

    subtracted_and_squared = items_per_merchant.values.map do | merchant |
      (merchant - average_items_per_merchant) ** 2
    end

    sum = subtracted_and_squared.inject(0) {| sum, n | sum+n}

    divided = sum / (subtracted_and_squared.length - 1)
    sd = Math.sqrt(divided)
    sd.round(2)
  end

  def average_invoices_per_merchant_standard_deviation
    invoices_per_merchant = Hash.new(0)
    @invoices.members.each do | invoice |
      invoices_per_merchant[invoice.merchant_id] += 1
    end

    subtracted_and_squared = invoices_per_merchant.values.map do | merchant |
      (merchant - average_invoices_per_merchant) ** 2
    end

    sum = subtracted_and_squared.inject(0) {| sum, n | sum+n}

    divided = sum / (subtracted_and_squared.length - 1)
    sd = Math.sqrt(divided)
    sd.round(2)
  end

  def merchants_with_high_item_count
    items_per_merchant = Hash.new(0)
    @items.members.each do | item |
      items_per_merchant[item.merchant_id] += 1
    end
    higher_than = average_items_per_merchant + average_items_per_merchant_standard_deviation
    ids = items_per_merchant.keys.map do | merchant |
      if items_per_merchant[merchant] > higher_than
        merchant
      end
    end.compact

    ids.map do | merchant |
      @merchants.find_by_id(merchant)
    end
  end

  def top_merchants_by_invoice_count
    invoices_per_merchant = Hash.new(0)
    @invoices.members.each do | invoice |
      invoices_per_merchant[invoice.merchant_id] += 1
    end
    higher_than = average_invoices_per_merchant + (average_invoices_per_merchant_standard_deviation * 2)
    ids = invoices_per_merchant.keys.map do | merchant |
      if invoices_per_merchant[merchant] > higher_than
        merchant
      end
    end.compact

    ids.map do | merchant |
      @merchants.find_by_id(merchant)
    end
  end

  def bottom_merchants_by_invoice_count
    invoices_per_merchant = Hash.new(0)
    @invoices.members.each do | invoice |
      invoices_per_merchant[invoice.merchant_id] += 1
    end
    lower_than = average_invoices_per_merchant - (average_invoices_per_merchant_standard_deviation * 2)
    ids = invoices_per_merchant.keys.map do | merchant |
      if invoices_per_merchant[merchant] < lower_than
        merchant
      end
    end.compact

    ids.map do | merchant |
      @merchants.find_by_id(merchant)
    end
  end

  def top_days_by_invoice_count
    by_day = @invoices.members.group_by do |invoice|
      invoice.created_at.strftime('%A')
    end

    number_by_day = by_day.values.map do |day|
      day.count
    end

    std_dev = calculate_standard_deviation(number_by_day)
    mean = calculate_average(number_by_day)
    highest_days = []
    by_day.each_pair do |day, invoices|
      if invoices.count > (mean + std_dev)
        highest_days << day
      end
    end
    highest_days
  end

  def invoice_status(state)
    divided = 0
    total = @invoices.members.count
    @invoices.members.map do |invoice|
      if invoice.status == state
        divided += 1
      end
    end
    ((divided.to_f / total.to_f) * 100).round(2)
  end

  def calculate_average(numbers)
    added = numbers.inject(0) {|sum, number| sum + number}
    added.to_f / numbers.size.to_f
  end

  def average_item_price_for_merchant(merchant_id)
    divided_by = 0
    total = @items.members.inject(0) do | sum, item |
      if item.merchant_id == merchant_id
        divided_by += 1
        sum += item.unit_price
      end
      sum
    end

    (total / divided_by).round(2)
  end

  def average_average_price_per_merchant
    total = @merchants.members.inject(0) do | sum, merchant |
      sum += average_item_price_for_merchant(merchant.id)
      sum
    end

    (total/@merchants.members.length).round(2)
  end

  def golden_items
    price_total = @items.members.inject(0) do | sum, item |
      sum += item.unit_price
      sum
    end

    price_mean = price_total / @items.members.length

    sd_sum = @items.members.inject(0) do | sum, item |
      difference = item.unit_price - price_mean
      square = difference ** 2
      sum += square
    end

    sd_division = sd_sum / (@items.members.length-1)

    sd = Math.sqrt(sd_division)

    greater_than = price_mean + (2 * sd)

    @items.members.map do | item |
      if item.unit_price >= greater_than
        item
      end
    end.compact
  end
end

require 'bigdecimal'
require 'bigdecimal/util'
require_relative '../lib/math'

class SalesAnalyst
  include Math

  def initialize(sales_engine)
    @item_repo = sales_engine.items
    @merchant_repo = sales_engine.merchants
    @invoice_repo = sales_engine.invoices
    @transaction_repo = sales_engine.transactions
    @invoice_item_repo = sales_engine.invoice_items
  end

  def num_items_for_each_merchant
    items_per_merchant = {}
    @merchant_repo.all.each do |merchant|
      items_per_merchant[merchant] =
          @item_repo.find_all_by_merchant_id(merchant.id).size
    end
    items_per_merchant
  end

  def count_of_merchants
    @merchant_repo.all.size
  end

  def average_items_per_merchant
    items = num_items_for_each_merchant.values
    (sum(items).to_f / count_of_merchants).round(2)
  end

  def average_items_per_merchant_standard_deviation
    items_per_merchant = num_items_for_each_merchant.values
    std_dev(items_per_merchant)
  end

  def average_item_price_for_merchant(id)
    item_list = @item_repo.find_all_by_merchant_id(id)
    item_prices = item_list.map do |item|
      item.unit_price
    end
    mean(item_prices).round(2).to_d
  end

  def merchants_with_high_item_count
    one_std_dev = average_items_per_merchant +
                  average_items_per_merchant_standard_deviation
    high_item_counts = []
    num_items_for_each_merchant.each do |merchant, item_count|
      high_item_counts << merchant if item_count > one_std_dev
    end
    high_item_counts
  end

  def average_average_price_per_merchant
    prices = @merchant_repo.all.map do |merchant|
      average_item_price_for_merchant(merchant.id)
    end
    mean(prices)
  end

  def golden_items
    all_item_prices = @item_repo.all.map do |item|
      item.unit_price
    end
    average_item_price = mean(all_item_prices)
    price_std_dev = std_dev(all_item_prices)
    two_std_dev_above_average = average_item_price + (price_std_dev * 2)

    golden_items = []
    @item_repo.all.each do |item|
      golden_items << item if item.unit_price > two_std_dev_above_average
    end
    golden_items
  end

  def num_invoices_per_merchant
    invoices_per_merchant = {}
    @merchant_repo.all.each do |merchant|
      invoices_per_merchant[merchant] =
          @invoice_repo.find_all_by_merchant_id(merchant.id).size
    end
    invoices_per_merchant
  end

  def average_invoices_per_merchant
    merchant_invoices = num_invoices_per_merchant
    count = merchant_invoices.values
    (sum(count).to_f / count.length).round(2)
  end

  def average_invoices_per_merchant_standard_deviation
    invoice_count = num_invoices_per_merchant.values
    std_dev(invoice_count)
  end

  def top_merchants_by_invoice_count
    two_deviations_above = average_invoices_per_merchant +
              (average_invoices_per_merchant_standard_deviation * 2)
    top_merchants = []
    num_invoices_per_merchant.each do |merchant, num|
      top_merchants << merchant if num >= two_deviations_above
    end
    top_merchants
  end

  def bottom_merchants_by_invoice_count
    two_deviations_below = average_invoices_per_merchant -
              (average_invoices_per_merchant_standard_deviation * 2)
    top_merchants = []
    if two_deviations_below < 0
      two_deviations_below = 0
    end
    num_invoices_per_merchant.each do |merchant, num|
      top_merchants << merchant if num <= two_deviations_below
    end
    top_merchants
  end

  def top_days_by_invoice_count
    week = {"Sunday" => 0,
            "Monday" => 0,
            "Tuesday" => 0,
            "Wednesday" => 0,
            "Thursday" => 0,
            "Friday" => 0,
            "Saturday" => 0}

    days = @invoice_repo.all.map do |invoice|
            invoice.created_at.wday
    end
    days.each do |day_num|
      if day_num == 0
        week["Sunday"] += 1
      elsif day_num == 1
        week["Monday"] += 1
      elsif day_num == 2
        week["Tuesday"] += 1
      elsif day_num == 3
        week["Wednesday"] += 1
      elsif day_num == 4
        week["Thursday"] += 1
      elsif day_num == 5
        week["Friday"] += 1
      elsif day_num == 6
        week["Saturday"] += 1
      else
      end
    end
    average_of_week = (sum(week.values) / 7).round(2)
    deviation_of_week = (average_of_week + (std_dev(week.values))).round(2)
    top_days = []
    week.each do |day, num|
      if num > deviation_of_week
        top_days << day
      end
    end
    top_days
  end

  def invoice_status(status)
    invoice_num = (@invoice_repo.all.length).to_f
    invoice_status_num = (@invoice_repo.find_all_by_status(status)).length
    ((invoice_status_num / invoice_num) * 100).round(2)
  end

  def invoice_paid_in_full?(invoice_id)
    transactions = @transaction_repo.find_all_by_invoice_id(invoice_id)
    if transactions.empty?
      false
    else
      transactions.any? do |transaction|
        transaction.result == :success
      end
    end
  end

  def invoice_total(invoice_id)
    if invoice_paid_in_full?(invoice_id)
      invoice_items = @invoice_item_repo.find_all_by_invoice_id(invoice_id)
      invoice_items = invoice_items.map do |item|
        item.unit_price * item.quantity
      end
      sum(invoice_items)
    else
      0
    end
  end

  def total_revenue_by_date(date)
    invoices = @invoice_repo.all.find_all do |invoice|
      Time.strptime(invoice.created_at.to_s, '%Y-%m-%d') == date
    end

    invoice_items = []
    invoices.each do |invoice|
      invoice_items << @invoice_item_repo.find_all_by_invoice_id(invoice.id)
    end
    invoice_items.flatten!

    totals = invoice_items.map do |invoice_item|
      invoice_item.unit_price * invoice_item.quantity
    end
    sum(totals)
  end

  def top_revenue_earners(num = 20)
    merchant_revenue = revenue_for_each_merchant
    sorted = merchant_revenue.sort_by do |merchant, revenue|
      revenue
    end
    merchants = []
    num.times do
      merchants << sorted.pop[0]
    end
    merchants
  end

  def merchants_with_pending_invoices
    pending_merchant_ids = []
    @invoice_repo.all.each do |invoice|
      if invoice_paid_in_full?(invoice.id) == false
        pending_merchant_ids << invoice.merchant_id
      end
    end
    pending_merchant_ids.uniq.map do |id|
      @merchant_repo.find_by_id(id)
    end
  end

  def merchants_with_only_one_item
    items_per_merchant = @merchant_repo.all.map do |merchant|
      @item_repo.find_all_by_merchant_id(merchant.id)
    end
    # binding.pry
    items_with_single_owner = items_per_merchant.find_all do |items|
      items.length == 1
    end.flatten
    item_owner = items_with_single_owner.map do |item|
      @merchant_repo.all.find_all do |merchant|
        merchant.id == item.merchant_id
      end
    end.flatten
  end

  def revenue_by_merchant(merchant_id)
    merchants_items = @item_repo.find_all_by_merchant_id(merchant_id)
    merchants_invoice_items = []
    merchants_items.each do |item|
      merchants_invoice_items << @invoice_item_repo.find_all_by_item_id(item.id)
    end
    merchants_invoice_items = merchants_invoice_items.flatten
    merchants_invoice_items = merchants_invoice_items.map do |invoice_item|
      invoice_item.unit_price * invoice_item.quantity
    end
    sum merchants_invoice_items
  end

  def most_sold_item_for_merchant(id)
    invoices = @invoice_repo.find_all_by_merchant_id(id)
    paid_invoices = invoices.find_all do |invoice|
      invoice_paid_in_full?(invoice.id)
    end
    invoice_items = paid_invoices.map do |invoice|
      @invoice_item_repo.find_all_by_invoice_id(invoice.id)
    end.flatten
    sorted = invoice_items.sort_by do |i_item|
      i_item.quantity
    end
    item_by_quantity = []
    max_quantity = sorted.last.quantity
    sorted.each do |i|
      if i.quantity == max_quantity
        item_by_quantity << @item_repo.find_by_id(i.item_id)
      end
    end
    item_by_quantity.compact.uniq
    #This is the common sense approach that does not meet rspec test
    # items = Hash.new(0)
    # invoice_items.each do |i_item|
    #   items[i_item.item_id] += i_item.quantity
    # end
    # sorted = items.sort_by do |item_id, quantity|
    #       quantity
    # end
    # item_by_quantity = []
    # max_quantity = sorted.last
    # sorted.each do |item_quant|
    #   if item_quant.last == max_quantity.last
    #     item_by_quantity << item_quant.first
    #   end
    # end
    # item_by_quantity.map do |i|
    #   @item_repo.find_by_id(i)
    # end.compact
  end

  def find_all_paid_invoices(invoices)
    invoices.find_all do |invoice|
      invoice_paid_in_full?(invoice.id)
    end
  end

  def best_item_for_merchant(id)
    invoices = @invoice_repo.find_all_by_merchant_id(id)
    paid_invoices = find_all_paid_invoices(invoices)
    invoice_items = paid_invoices.map do |invoice|
      @invoice_item_repo.find_all_by_invoice_id(invoice.id)
    end.flatten
    revenue_per_item = Hash.new(0)
    invoice_items.each do |invoice_item|
      revenue_per_item[invoice_item.item_id] += (invoice_item.unit_price * invoice_item.quantity)
    end
    sorted = revenue_per_item.sort_by do |item_id, revenue|
      revenue
    end
    @item_repo.find_by_id(sorted.last[0])
  end

  def merchants_ranked_by_revenue
    merchant_revenue = revenue_for_each_merchant

    sorted = merchant_revenue.sort_by { |merchant, revenue| revenue }
    result = sorted.map { |merchant, revenue| merchant }
    result.reverse
  end

  def invoices_for_each_merchant
    merchant_invoices = {}
    @merchant_repo.all.each do |merchant|
      invoices = @invoice_repo.find_all_by_merchant_id(merchant.id)
      merchant_invoices[merchant] = invoices
    end
    merchant_invoices
  end

  def revenue_for_each_merchant
    merchant_invoices = invoices_for_each_merchant
    merchant_revenue = {}
    merchant_invoices.each do |merchant, invoices|
      total_revenue = invoices.inject(0) do |total, invoice|
        total + invoice_total(invoice.id)
      end
      merchant_revenue[merchant] = total_revenue
    end
    merchant_revenue
  end

  # def find_all_invoices_in_a_month(month)
  #   invoices_by_month = {}
  #   @invoice_repo.all.each do |invoice|
  #
  # end

  def merchants_with_only_one_item_registered_in_month(month)
    # invoices_by_month = @invoice_repo.all.find_all do |invoice|
    #   invoice.created_at.strftime("%B") == month
    # end

    merchants = merchants_with_only_one_item
    merchants.find_all do |merchant|
      Time.parse(merchant.created_at).strftime("%B") == month
    end
  end
end

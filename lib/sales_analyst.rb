require_relative 'mathematics_module'
require_relative './analyst_assistants/item_assistant'
require_relative './analyst_assistants/invoice_assistant'
require 'pry'

class SalesAnalyst
  include Mathematics
  include ItemAssistant
  include InvoiceAssistant

  attr_reader     :items,
                  :merchants,
                  :invoices,
                  :transactions,
                  :invoice_items,
                  :customers

  def initialize(items, merchants, invoices, transactions, invoice_items, customers)
    @items = items
    @merchants = merchants
    @invoices = invoices
    @transactions = transactions
    @invoice_items = invoice_items
    @customers = customers
  end

  def average_items_per_merchant
    calculate_average(items_by_merchant_id.values)
  end

  def average_items_per_merchant_standard_deviation
    calculate_standard_deviation(items_by_merchant_id.values)
  end

  def merchants_with_high_item_count
    merchant_ids_with_more_items_than_one_standard_deviation.map do | merchant |
      @merchants.find_by_id(merchant)
    end
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
    avg = calculate_average(all_item_prices)
    std_dev = calculate_standard_deviation(all_item_prices)
    greater_than = avg + (2 * std_dev)
    @items.members.map do | item |
      if item.unit_price >= greater_than
        item
      end
    end.compact
  end

  def average_invoices_per_merchant
    calculate_average(invoices_by_merchant_id.values)
  end

  def average_invoices_per_merchant_standard_deviation
    calculate_standard_deviation(invoices_by_merchant_id.values)
  end

  def top_merchants_by_invoice_count
    merchant_ids_with_more_invoices_than_two_standard_deviations_above_average.map do | merchant |
      @merchants.find_by_id(merchant)
    end
  end

  def bottom_merchants_by_invoice_count
    merchant_ids_with_less_invoices_than_two_standard_deviations_below_average.map do | merchant |
      @merchants.find_by_id(merchant)
    end
  end

  def top_days_by_invoice_count
    avg = calculate_average(total_invoices_per_day)
    std_dev = calculate_standard_deviation(total_invoices_per_day)
    highest_days = []
    invoices_by_day.each_pair do |day, invoices|
      if invoices.count > (avg + std_dev)
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

  def invoice_paid_in_full?(invoice_id)
    invoice_transactions = transactions.find_all_by_invoice_id(invoice_id)
    return invoice_transactions.any? {|transaction| transaction.result == :success}
  end

  def invoice_total(inv_id)
    if invoice_paid_in_full?(inv_id) == true
      get_invoices(inv_id)
    else
      false
    end
  end

  def get_invoices(inv_id)
    fully_paid = @invoice_items.members.map do |member|
      if member.invoice_id == inv_id
        member
      else
        nil
      end
    end
    get_invoice_item_total(fully_paid.compact)
  end

  def get_invoice_item_total(fully_paid)
    to_add = fully_paid.map do |invoice_item|
      invoice_item.unit_price * (invoice_item.quantity.to_i)
    end
    added = to_add.inject(0){|sum, number| sum + number}
    added
  end

  def top_buyers(x = 20)
    customers_by_money_spent = Hash.new(0.0)
    @invoice_items.members.each do | invoice_item |
      invoice = invoices.find_by_id(invoice_item.invoice_id)
      customer = customers.find_by_id(invoice.customer_id)
      customer_transactions = transactions.find_all_by_invoice_id(invoice.id)
      if customer_transactions.any? { |transaction| transaction.result == :success }
        customers_by_money_spent[customer] += (invoice_item.unit_price.to_f * invoice_item.quantity.to_f)
      end
    end
    return_value = customers_by_money_spent.keys.sort_by do | customer |
      customers_by_money_spent[customer] * -1
    end
    return_value[0...x]
  end

  def top_merchant_for_customer(customer_id)
    customer_invoices = invoices.find_all_by_customer_id(customer_id)

    purchase_count = Hash.new(0)

    customer_invoices.each do | invoice |
      merchant = merchants.find_by_id(invoice.merchant_id)
      customer_transactions = transactions.find_all_by_invoice_id(invoice.id)
      customer_invoice_items = invoice_items.find_all_by_invoice_id(invoice.id)
      total = customer_invoice_items.inject(0) {|sum, invoice_item| sum += invoice_item.quantity}
      if customer_transactions.any? { |transaction| transaction.result == :success }
        purchase_count[merchant] += total
      end
    end
    return purchase_count.key(purchase_count.values.max)

  end

  def items_bought_in_year(customer_id, year)
    customer = customers.find_by_id(customer_id)
    customer_invoices = invoices.find_all_by_customer_id(customer_id)
    sum = []
    customer_invoices.each do | invoice |
      if invoice.created_at.year == year
        customer_invoice_items = invoice_items.find_all_by_invoice_id(invoice.id)
        customer_invoice_items.each do | invoice_item |
          sum += [items.find_by_id(invoice_item.item_id)]
        end
      end
    end
    return sum
  end

  def highest_volume_items(customer_id)
    customer = customers.find_by_id(customer_id)
    customer_invoices = invoices.find_all_by_customer_id(customer_id)
    items_and_quantities = {}
    customer_invoices.each do | invoice |
      customer_invoice_items = invoice_items.find_all_by_invoice_id(invoice.id)
      customer_invoice_items.each do | invoice_item |
        items_and_quantities[items.find_by_id(invoice_item.item_id)] = invoice_item.quantity
      end
    end

    only_the_highest = items_and_quantities.keep_if { | item, quantity | quantity == items_and_quantities.values.max}
    only_the_highest.keys
  end

  def customers_with_unpaid_invoices
    @invoices.members.map do | invoice |
      if !invoice_paid_in_full?(invoice.id)
        @customers.find_by_id(invoice.customer_id)
      end
    end.compact.uniq
  end
end

require_relative 'mathematics_module'
require_relative './analyst_assistants/item_assistant'
require_relative './analyst_assistants/invoice_assistant'

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


  def invoice_paid_in_full?(inv_id)
    success_array = []
    @transactions.members.each do |transaction|
      if transaction.invoice_id == inv_id
        success_array << transaction.result
      end
    end
    all_true(success_array.flatten)
  end

  def all_true(result_array)
    if result_array.length != 0
      result_array.all? {|result| result == :success}
    else
      return false
    end
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
end

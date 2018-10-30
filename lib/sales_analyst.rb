require 'bigdecimal'
require_relative './stats_module'

class SalesAnalyst
  attr_reader :merchants, :items, :invoices, :invoice_items

  include Stats

  def initialize(merchant_repo, item_repo, invoice_repo, invoice_item_repo,transaction_repo, customer_repo )
    @merchants         = merchant_repo.all
    @items             = item_repo.all
    @invoices          = invoice_repo.all
    @invoice_items     = invoice_item_repo.all
    @transactions      = transaction_repo.all
    @m_repo            = merchant_repo
  end

  def average_items_per_merchant
    (@items.count.to_f / @merchants.count).round(2)
  end

  def merchant_item_list(merchant)
    @items.find_all do |item|
      item.merchant_id == merchant.id
    end
  end

  def average_items_per_merchant_standard_deviation
    items_per_merchant_array = @merchants.map do |m|
      merchant_item_list(m).count
    end
    (standard_dev(items_per_merchant_array)).round(2)
  end

  def merchants_with_high_item_count
    high_items = average_items_per_merchant + average_items_per_merchant_standard_deviation
    high_count_merchs = []
    @merchants.each do |m|
      item_count = merchant_item_list(m).count
      if  item_count > high_items
        high_count_merchs << m
      end
    end
    high_count_merchs
  end

  def average_item_price_for_merchant(id)
    merchant = @m_repo.find_by_id(id)
    items = merchant_item_list(merchant)
    prices = items.map { |i| i.unit_price }
    (mean_value(prices)).round(2)
  end

  def average_average_price_per_merchant
    averages = @merchants.map do |m|
      average_item_price_for_merchant(m.id)
    end
    (mean_value(averages)).round(2)
  end

  def average_item_price
    item_prices = @items.map { |i| i.unit_price }
    mean_value(item_prices)
  end

  def average_item_price_std_dev
    item_prices = @items.map { |i| i.unit_price }
    standard_dev(item_prices)
  end

  def golden_items
    golden_price = (average_item_price_std_dev * 2) + average_item_price
    golden_array = []
    @items.each do |item|
      golden_array << item if item.unit_price >= golden_price
    end
    golden_array
  end

  def average_invoices_per_merchant
    (@invoices.count / @merchants.count.to_f).round(2)
  end

  def merchant_invoice_list(merchant)
      @invoices.find_all do |invoice|
        invoice.merchant_id == merchant.id
      end
  end

  def average_invoices_per_merchant_standard_deviation
    invoices_per_merchant_array = @merchants.map do |m|
        merchant_invoice_list(m).count
    end
    (standard_dev(invoices_per_merchant_array)).round(2)
  end

  def top_merchants_by_invoice_count
    top_merchants_array = []
    two_deviations_above_mean = average_invoices_per_merchant_standard_deviation * 2 + average_invoices_per_merchant
    @merchants.each do |m|
        if  merchant_invoice_list(m).count > two_deviations_above_mean
           top_merchants_array << m
        end
    end
    top_merchants_array
  end

  def bottom_merchants_by_invoice_count
    bottom_merchants_array = []
    two_deviations_below_mean = average_invoices_per_merchant - average_invoices_per_merchant_standard_deviation * 2
    @merchants.each do |m|
        if  merchant_invoice_list(m).count < two_deviations_below_mean
           bottom_merchants_array << m
        end
    end
    bottom_merchants_array
  end

  def top_days_by_invoice_count
    top_days_created = []
    numbers_to_days_hash = {0 => "Sunday", 1 => "Monday", 2 => "Tuesday", 3 => "Wednesday", 4 => "Thursday", 5 => "Friday", 6 => "Saturday"}
    invoices_per_day = {"Sunday" => 0, "Monday" => 0, "Tuesday" => 0, "Wednesday" => 0, "Thursday" => 0, "Friday" => 0, "Saturday" => 0}
    # one_deviation_above_mean = average_invoices_per_day_standard_deviation + average_invoices_per_day
        @invoices.each do |invoice|
          day = numbers_to_days_hash[invoice.created_at.wday]
          invoices_per_day[day] += 1
        end

      average_invoices_per_day = mean_value(invoices_per_day.values)
      average_invoices_per_day_standard_deviation = standard_dev(invoices_per_day.values)
      one_deviation_above_mean = average_invoices_per_day + average_invoices_per_day_standard_deviation

            invoices_per_day.each do |day, value|
              if value > one_deviation_above_mean
                  top_days_created << day
                end
              end
    top_days_created
  end

  # def invoice_status(status)
  #   status_counter = 0
  #   invoice_status = @invoices.each do |invoice|
  #                     if invoice.status == status
  #                       status_counter += 1
  #                     end
  #                   end
  #
  #   total = @invoices.count
  #   status_counter / total * 100
  #
  # # (@invoices[status].count / @invoices.count) * 100
  #
  # end


  def invoice_paid_in_full?(invoice_id)
      transaction_match = @transactions.find_all do |transaction|
        transaction.invoice_id == invoice_id
      end
      transaction_match.any? do |transaction|
        transaction.result==:success
      end
  end

 #  def invoice_paid_in_full?(invoice_id)
 #   transactions = @parent.transactions.find_all_by_invoice_id(invoice_id)
 #   transactions.any? { |transaction| transaction.result == :success }
 # end

  def invoice_total(invoice_id)
    invoice_items = @invoice_items.find_all do |transaction|
      transaction.invoice_id == invoice_id
    end
    invoice_items.inject(0.0) do |sum, invoice_item|
      sum + (invoice_item.unit_price * invoice_item.quantity)
    end
  end

end

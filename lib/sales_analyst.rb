require 'bigdecimal'
require_relative './stats_module'

class SalesAnalyst
  attr_reader :merchants, :items, :invoices, :invoice_items

  include Stats

  def initialize(merchant_repo, item_repo, invoice_repo, invoice_item_repo,transaction_repo, customer_repo )
    @merchants         = merchant_repo.repo_array
    @items             = item_repo.repo_array
    @invoices          = invoice_repo.repo_array
    @invoice_items     = invoice_item_repo.repo_array
    @m_repo            = merchant_repo
    @transactions      = transaction_repo.repo_array
    @customers         = customer_repo
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
    two_deviations_above_mean = (average_invoices_per_merchant_standard_deviation * 2 + average_invoices_per_merchant)
    invoices_per_merchant_array = @merchants.map do |m|
        merchant_invoice_list(m).count
    end
      invoices_per_merchant_array.each do |n|
        if  n > two_deviations_above_mean
          top_merchants_array << n
        end
      end
      # this needs to be outputting merchant instances or names... not sure...
      # not just the number of invoices
    end
  end

  # def bottom_merchants_by_invoice_count
  #    #Which merchants are more than two standard deviations below the mean?

  # end

  # def top_days_by_invoice_count
  # On which days are invoices created at more than one standard deviation above the mean?
  # end

  # def invoice_status(status)
  # # What percentage of invoices are shipped vs pending vs returned?
  # # (total invoices for that status / total invoices) * 100
  # # Need to map through this.
  # (@invoices[status].count / @invoices.count) * 100
  # # the above line might not be quite right
  # end


  def invoice_paid_in_full?(invoice_id)
      transaction_match = @transactions.find do |transaction|
        transaction.invoice_id == invoice_id
      end
      if transaction_match.result == "success"
        true
      else
      end
  end

  def invoice_total(invoice_id)
    invoice_items = @invoice_items.find_all do |transaction|
      transaction.invoice_id == invoice_id
    end
    invoice_items.inject(0.0) do |sum, invoice_item|
      sum + (invoice_item.unit_price * invoice_item.quantity)
    end

  end


end
# use #all method?

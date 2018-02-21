require 'date'
require 'pry'

module InvoiceAnalyst

  def average_invoices_per_merchant
    (total_invoices/total_merchants).round(2)
  end

  def find_invoices_per_merchant
    pull_all_merchant_ids.map do |merchant_id|
      @invoices.find_all_by_merchant_id(merchant_id).count
    end
  end

  def merchants_and_invoice_count
    Hash[pull_all_merchant_ids.zip find_invoices_per_merchant]
  end

  def calculate_invoice_std_dev
    sum = find_invoices_per_merchant.reduce(0) {|result, merchant|
      squared_difference = (average_invoices_per_merchant - merchant) ** 2
      result + squared_difference}
    Math.sqrt(sum / (total_merchants-1)).round(2)
  end

  def average_invoices_per_merchant_standard_deviation
    calculate_invoice_std_dev
  end

  def top_merchants_by_invoice_count
    high_invoice_count_merchant_ids.map do |merchant_id|
      @merchants.find_by_id(merchant_id)
    end
  end

  def high_invoice_count_merchant_ids
    std_dev = calculate_invoice_std_dev
    merchants_and_invoice_count.map do |merchant_id,invoice_count|
      merchant_id if invoice_count > (average_invoices_per_merchant+(std_dev*2))
    end.compact
  end

  def bottom_merchants_by_invoice_count
    low_invoice_count_merchant_ids.map do |merchant_id|
      @merchants.find_by_id(merchant_id)
    end
  end

  def low_invoice_count_merchant_ids
    std_dev = calculate_invoice_std_dev
    merchants_and_invoice_count.map do |merchant_id,invoice_count|
      merchant_id if invoice_count < (average_invoices_per_merchant-(std_dev*2))
    end.compact
  end

  def average_invoices_per_day
    total_invoices/7
  end

  def invoice_std_dev
    Math.sqrt(invoice_std_dev_calculate_sum / (total_invoices-1)).round(2)
  end

  def days_of_the_week
    {"Sunday"=>0,"Monday"=>0,
    "Tuesday"=>0,"Wednesday"=>0,
    "Thursday"=>0,"Friday"=>0,
    "Saturday"=>0,}
  end

  def invoices_per_day
    @invoices.all.reduce(days_of_the_week) do |result, invoice|
        result[Time.parse(invoice.created_at.to_s).strftime("%A")] += 1
        result
    end
  end

  def invoice_count_std_dev
    sum = invoices_per_day.reduce(0) { |result, (_, count)|
      squared_difference = (average_invoices_per_day - count) ** 2
      result + squared_difference}
    Math.sqrt(sum / 6)
  end

  def top_days_by_invoice_count
    avg_invoices = average_invoices_per_day
    invoices_per_day.reduce([]) {|result, (day, invoice_count)|
      result << day if invoice_count > (avg_invoices + invoice_count_std_dev)
      result}
  end

  def invoice_status_sum
    starting_status = {:pending=>0, :shipped=>0, :returned=>0}
    @invoices.all.reduce(starting_status) {|result, invoice|
        result[invoice.status.to_sym] += 1
        result}
  end

  def invoice_status(invoice_status)
    percent = invoice_status_sum.reduce({}) {|result, (status, sum)|
      result[status] = (sum / total_invoices) * 100
      result}
    percent[invoice_status].round(2)
  end
end

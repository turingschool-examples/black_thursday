# frozen_string_literal: true

require_relative 'math_helper'

# ./liv/inoice_analyst
class InvoiceAnalyst
  include MathHelper
  def initialize(invoice_repository)
    @invoice_repo = invoice_repository
  end

  def group_invoices_by_merchant_id
    @invoice_repo.all.group_by(&:merchant_id)
  end

  def number_of_merchants
    group_invoices_by_merchant_id.keys.count
  end

  def average_invoices_per_merchant
    (@invoice_repo.all.size / number_of_merchants.to_f).round(2)
  end

  def average_invoices_per_day
    (@invoice_repo.all.size / 7.0).round(2)
  end

  def group_by_day
    @invoice_repo.all.group_by do |invoice|
      Time.parse(invoice.created_string).strftime('%A')
    end
  end

  def percent_by_invoice_status(status)
    grouped_by_status = @invoice_repo.all.group_by(&:status)
    percent = grouped_by_status[status].size.to_f / @invoice_repo.all.size
    (percent * 100).round(2)
  end

  def average_invoices_per_day_standard_deviation
    mean_total_sqr = group_by_day
    mean_items_per = average_invoices_per_day
    final_square(mean_total_sqr, mean_items_per)
  end

  def average_invoices_per_merchant_standard_deviation
    mean_total_sqr = group_invoices_by_merchant_id
    mean_items_per = average_invoices_per_merchant
    final_square(mean_total_sqr, mean_items_per)
  end

  def merchants_with_high_item_count
    stdev   = average_items_per_merchant_standard_deviation
    average = average_items_per_merchant
    hash    = @item_repository.group_item_by_merchant_id
    array   = []
    hash.each do |id, items|
      array << @merchant_repository.find_by_id(id) if items.count > (stdev + average)
    end
    array
  end
end

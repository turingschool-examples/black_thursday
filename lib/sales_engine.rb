require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'invoice_repository'
require_relative 'load_data'
require          'csv'

class SalesEngine
  attr_reader :repo_rows
  attr_accessor :items, :merchants, :invoices

  def initialize(repo_rows)
    start_up_engine(repo_rows)
  end


  def self.from_csv(csv_hash)
    repo_rows = csv_hash.map do |type, filename|
      [type, LoadData.load_data(filename)]
    end.to_h
    SalesEngine.new(repo_rows)
  end

  def start_up_engine(repo_rows)
    load_merchants_repo(repo_rows) if repo_rows[:merchants]
    load_items_repo(repo_rows) if repo_rows[:items]
    load_invoice_repo(repo_rows) if repo_rows[:invoices]
  end

  def load_merchants_repo(repo_rows)
    @merchants  = MerchantRepository.new(repo_rows[:merchants])
  end

  def load_items_repo(repo_rows)
    @items      = ItemRepository.new(repo_rows[:items])
    if repo_rows[:items]
      items_to_merchants
      merchants_to_items
    end
  end

  def load_invoice_repo(repo_rows)
    @invoices   = InvoiceRepository.new(repo_rows[:invoices])
    if repo_rows[:merchants]
      invoices_to_merchants
      merchants_to_invoices
    end
  end


  def items_to_merchants
    @merchants.all.map { |merchant|
      merchant.items = @items.find_all_by_merchant_id(merchant.id)}
  end

  def merchants_to_items
    @items.all.map { |item|
      item.merchant = @merchants.find_by_id(item.merchant_id)}
  end

  def invoices_to_merchants
    @merchants.all.map { |merchant|
      merchant.invoices = @invoices.find_all_by_merchant_id(merchant.id)}
  end

  def merchants_to_invoices
    @invoices.all.map { |invoice|
      invoice.merchant = @merchants.find_by_id(invoice.merchant_id)}
  end
end
# 
# #Top Days by Invoice Count =====================================
# def top_days_by_invoice_count
#   hash_of_invoices_to_day_of_the_week
#   x = return_weekday_hash_and_key_for_top_days.map(&:key)
#   binding.pry
# end
#
# def return_weekday_hash_and_key_for_top_days
#   benchmark = average_invoices_per_merchant_standard_deviation
#   @wday_created.find_all { |wday_invoices|
#     wday_invoice.value > benchmark }
# end
#
# def hash_of_invoices_to_day_of_the_week
#   days_of_the_week_hash
#   se.invoices.all.each do |invoice|
#     day = invoice.created_at.strftime('%A').to_sym
#     @wday_created[day] = @wday_created[day] += 1
#   end
#   @wday_created
# end
#
# def days_of_the_week_hash
#   @wday_created = { Sunday: 0,
#                     Monday: 0,
#                    Tuesday: 0,
#                  Wednesday: 0,
#                   Thursday: 0,
#                     Friday: 0,
#                   Saturday: 0
#                 }
# end
#
#
# # Standard deviation for top days by invoice ================
# def average_invoices_per_merchant_standard_deviation #can't change
#   x =Math.sqrt(variance_days).round(2)
# end
#
# def variance_days
#   sum_deviations_from_the_mean_invoices / (number_of_invoices - 1)
# end
#
# def sum_deviations_from_the_mean_invoices
#   invoices_per_day_of_the_week.inject(0) { |accum, invoices|
#     accum + (invoices - average_invoices_per_day) ** 2 }
# end
#
# def invoices_per_day_of_the_week
#   @wday_created.map(&:values)
# end
#
# # Average invoices per day for top days by invoice============
# def average_invoices_per_day
#   (number_of_invoices / 7).round(2)
# end
#
# def number_of_invoices
#   se.invoices.all.count
# end

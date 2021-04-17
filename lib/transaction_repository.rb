require_relative 'sales_engine'
require_relative 'transaction'
require_relative 'mathable'

class TransactionRepository
  include Mathable
  attr_reader :transactions

  def initialize(path, engine)
    @transactions = []
    @engine = engine
    make_transactions(path)
  end

  def inspect
    "#<#{self.class} #{@transactions.size} rows>"
  end

  def make_transactions(path)
    CSV.foreach(path, headers: true, header_converters: :symbol) do |row|
      @transactions << Transaction.new(row, self)
    end
  end

  def all
    @transactions
  end

  def find_by_id(id)
    @transactions.find do |transaction|
      transaction.id == id
    end
  end

  def find_all_by_invoice_id(invoice_id)
    @transactions.find_all do |transaction|
      transaction.invoice_id == invoice_id
    end
  end

  def find_all_by_credit_card_number(credit_card_number)
    @transactions.find_all do |transaction|
      transaction.credit_card_number == credit_card_number
    end
  end

  def find_all_by_result(result)
    @transactions.find_all do |transaction|
      transaction.result == result
    end
  end

  def generate_new_id
    highest_id_transaction = @transactions.max_by do |transaction|
      transaction.id
    end
    highest_id_transaction.id + 1
  end

  def create(attributes)
    attributes[:id] = generate_new_id
    @transactions << Transaction.new(attributes, self)
  end

  def update(id, attributes)
    if find_by_id(id) != nil 
      invoice_to_update = find_by_id(id)
      invoice_to_update.update(attributes)
    end
  end

  def delete(id)
    transactions.delete(find_by_id(id))
  end

#   def percentage_by_status(status)
#     invoices_found = find_all_by_status(status).count.to_f
#     total_invoices = all.count
#     (invoices_found / total_invoices * 100).round(2)
#   end

#   def invoices_by_days
#     hash = { 'Sunday' => 0,
#              'Monday' => 0,
#              'Tuesday' => 0,
#              'Wednesday' => 0,
#              'Thursday' => 0,
#              'Friday' => 0,
#              'Saturday' => 0 }
#     @invoices.each do |invoice|
#       hash[invoice.day_created] += 1
#     end
#     hash
#   end

#   def top_sales_days
#     hash = invoices_by_days
#     hash.each_with_object([]) do |(day, number_of_invoices), array|
#       if number_of_invoices > (average(hash) + standard_deviation(hash))
#         array << day
#       end
#     end
#   end

#   def invoices_per_merchant
#     @invoices.each_with_object(Hash.new(0)) do |invoice, hash|
#       hash[invoice.merchant_id] += 1
#     end
#   end

#   def average_invoices_per_merchant
#     average(invoices_per_merchant).round(2)
#   end

#   def stdev_invoices_per_merchant
#     standard_deviation(invoices_per_merchant).round(2)
#   end

#   def top_merchants_by_invoice_count
#     hash = invoices_per_merchant
#     hash.each_with_object([]) do |(merchant_id, number_of_invoices), array|
#       if number_of_invoices > average(hash) + (standard_deviation(hash) * 2)
#         array << @engine.find_merchant_by_id(merchant_id)
#       end
#     end
#   end

#   def bottom_merchants_by_invoice_count
#     hash = invoices_per_merchant
#     hash.each_with_object([]) do |(merchant_id, number_of_invoices), array|
#       if number_of_invoices < average(hash) - (standard_deviation(hash) * 2)
#         array << @engine.find_merchant_by_id(merchant_id)
#       end
#     end
#   end
end

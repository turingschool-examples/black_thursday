require_relative 'invoice_item'
require_relative 'item_repository'
require 'pry'

class Invoice

  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at

  attr_accessor :repository

  def initialize(row, repository = nil)
    @id          = row[:id].to_i
    @customer_id = row[:customer_id].to_i
    @merchant_id = row[:merchant_id].to_i
    @status      = row[:status].to_sym
    @created_at  = Time.parse(row[:created_at])
    @updated_at  = Time.parse(row[:updated_at])
    @repository  = repository
  end

  def merchant
    repository.sales_engine.merchants.find_by_id(self.merchant_id)
  end

  def invoice_items
    repository.sales_engine.invoice_items.invoice_items.select do |row|
      row.invoice_id == self.id
    end
  end

  def items
    matching_items = invoice_items
    matching_items.map do |item|
      repository.sales_engine.items.find_by_id(item.item_id)
    end
  end

  def transactions
    repository.sales_engine.transactions.find_all_by_invoice_id(self.id)
  end

  def customer
    repository.sales_engine.customers.find_by_id(self.customer_id)
  end

  def is_paid_in_full?
    transactions.any? {|tran| tran.result == "success"} && !transactions.empty?
  end

  def mod_paid_in_full?
    transactions.all? {|tran| tran.result == "success"} && !transactions.empty?
  end

  def total
    return 0.0 unless is_paid_in_full?
    items = repository.sales_engine.invoice_items.invoice_items.select do |row|
      row.invoice_id == self.id
    end

    items.select {}
    items.reduce(0) { |sum, item| sum + item.unit_price*item.quantity }
  end
end

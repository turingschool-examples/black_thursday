require 'time'
require 'pry'

class Merchant
  attr_reader :id,
              :name,
              :created_at,
              :updated_at,
              :merch_repo

  def initialize(merch_hash, merch_repo)
    @id         = merch_hash[:id].to_i
    @name       = merch_hash[:name].to_s
    @created_at = Time.parse(merch_hash[:created_at])
    @updated_at = Time.parse(merch_hash[:updated_at])
    @merch_repo = merch_repo
  end

  def items
    merch_repo.find_items_by_merchant_id(id)
  end

  def invoices
    merch_repo.find_invoices_by_merchant_id(id)
  end

  def customers
    merch_repo.find_customers_by_merchant_id(id)
  end

  def paid_invoices
  invoices.find_all do |invoice|
    invoice.is_paid_in_full?
    end
  end

  def invoice_items
    paid_invoices.map do |invoice|
      invoice.invoice_items
    end.flatten
  end

  def total_revenue
   invoices.reduce(0) do |sum, invoice|
     sum + invoice.total
   end
  end

  def pending_invoices?
    invoices.any? do |invoice|
      invoice.no_successful_transactions?
    end
  end

  def total_revenue
    invoices.reduce(0) do |sum, invoice|
      sum + invoice.total
    end
  end

end

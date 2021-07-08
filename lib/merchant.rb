require 'csv'
require 'time'
class Merchant

  attr_reader :id,
              :name,
              :created_at,
              :updated_at,
              :parent

  def initialize(data, repo = nil)
    @id           = data[:id].to_i
    @name         = data[:name]
    @created_at   = Time.parse(data[:created_at].to_s)
    @updated_at   = Time.parse(data[:updated_at].to_s)
    @parent       = repo
  end

  def items
    parent.items_of_merchant(id)
  end

  def find_unpaid_invoices
    invoices.select do |inv|
      !(inv.is_paid_in_full?)
    end
  end

  def invoices
    parent.parent.invoices.find_all_by_merchant_id(@id)
  end

  def customers
    find_invoices = invoices
    cust_inv = parent.parent.customers
    invoices.map do |invoice|
      cust_inv.find_by_id(invoice.customer_id)
    end.uniq
  end
end

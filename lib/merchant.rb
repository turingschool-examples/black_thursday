require 'pry'
require 'csv'
class Merchant

  attr_reader :id,
              :name,
              :parent

  def initialize(data, repo = nil)
    @id     = data[:id].to_i
    @name   = data[:name]
    @parent = repo
  end

  def items
  parent.items_of_merchant(id)
  end

  def find_invoices
    @se = parent.parent
    @all_inv = @se.invoices.find_all_by_merchant_id(@id )
  end
  def customers
    invoices = find_invoices
    cust_inv = parent.parent.customers
    invoices.map do |invoice|
      cust_inv.find_by_id(invoice.customer_id)
      end
    end
end

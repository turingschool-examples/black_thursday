require 'time'

class Merchant
  attr_reader :id,
              :name,
              :created_at,
              :updated_at,
              :parent

  def initialize(merchant,repo=nil)
    @id = merchant[:id].to_i
    @name = merchant[:name]
    @created_at = Time.parse(merchant[:created_at])
    @updated_at = Time.parse(merchant[:updated_at])
    @parent = repo
  end

  def items
    parent.merchant_items(self.id)
  end

  def invoices
    parent.merchant_invoices(self.id)
  end

  def customers
    parent.merchant_customers(self.id)
  end

  def total_revenue
    invoices.reduce(0) { |sum, invoice| sum + invoice.total }
  end

  def merchant_invoices_check_failed_transactions
    invoices.any? do |invoice|
      invoice.failed_transactions
    end
  end

end

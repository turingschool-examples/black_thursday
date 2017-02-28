require 'bigdecimal'
require 'time'

class Merchant
  attr_reader :id, :name, :repo, :created_at, :updated_at

  def initialize(row, repo)
    @id = row[:id].to_i
    @name = row[:name]
    @repo = repo
    @updated_at = Time.parse(row[:updated_at])
    @created_at = Time.parse(row[:created_at])
  end

  def items
    repo.sales_engine.items.find_all_by_merchant_id(self.id)
  end

  def invoices
    repo.sales_engine.invoices.find_all_by_merchant_id(self.id)
  end

  def customers
    uniq_customers = []
    invoices.each do | invoice|
      unless uniq_customers.include?(invoice.customer)
        uniq_customers << invoice.customer
      end
    end
    uniq_customers
  end

  def revenue
    invoices.map { |invoice| invoice.total }.reduce(:+)
  end

  def has_pending_invoices?
    !invoices.all? { |invoice| invoice.is_paid_in_full? }
  end

  def month_to_string
    @created_at.strftime('%B')
  end

end

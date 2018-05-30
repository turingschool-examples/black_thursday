# Merchant Class
class Merchant
  attr_reader :id,
              :name,
              :created_at,
              :merchant_repo

  def initialize(data, parent = nil)
    @id              = data[:id].to_i
    @name            = data[:name]
    @created_at      = Time.parse(data[:created_at])
    @merchant_repo   = parent
  end

  def items
    merchant_repo.find_items_by_merchant_id(id)
  end

  def invoices
    merchant_repo.find_invoices_by_merchant_id(id)
  end

  def customers
    invoices.map(&:customer).uniq.compact
  end

  def revenue
    invoices.reduce(0) do |result, invoice|
      result += invoice.total if invoice.is_paid_in_full?
      result
    end
  end
end

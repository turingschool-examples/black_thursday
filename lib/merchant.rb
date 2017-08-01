require 'time'
class Merchant
  attr_reader :id,
              :name,
              :created_at,
              :updated_at

  def initialize(data, repo)
    @repo = repo
    @id = data[:id].to_i
    @name = data[:name]
    @created_at = Time.parse(data[:created_at])
    @updated_at = Time.parse(data[:updated_at])
  end

  def items
    @repo.search(items.find_all_by_merchant_id(self.id))
  end

  def invoices
    @repo.search.invoices.find_all_by_merchant_id(self.id)
  end

  def customers
    invoices.map do |invoice|
      @repo.search.customers.find_by_id(invoice.customer_id)
    end.uniq
  end

end

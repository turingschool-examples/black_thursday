class Merchant

  attr_reader :id,
              :name,
              :parent_repo

  def initialize(datum, parent_repo = nil)
    @id = datum[:id].to_i
    @name = datum[:name]
    @parent_repo = parent_repo
  end

  def items
    parent_repo.find_items(id)
  end

  def invoices
    parent_repo.find_invoices(id)
  end

  def customers
    parent_repo.find_customers(id) do |invoices|
      return invoices.map do |invoice|
        invoice.customer
      end.compact.uniq
    end
  end

end

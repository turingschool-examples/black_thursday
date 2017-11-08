class Merchant
  attr_reader :name,
              :id,
              :parent,
              :created_at,
              :updated_at

  def initialize(info = {}, parent=nil)
    @name          = info[:name]
    @id            = info[:id].to_i
    @merchant_repo = parent
    @created_at    = info[:created_at]
    @updated_at    = info[:updated_at]
  end

  def items
    @merchant_repo.find_all_by_merchant_id(id)
  end

  def invoices
    @merchant_repo.find_invoices_for_merchant(id)
  end

  def customers
    invoices.map do |invoice|
      invoice.customer
    end.uniq
  end
end

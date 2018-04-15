class Merchant
  attr_reader :id,
              :created_at,
              :merchant_repo,
              :name,
              :updated_at
  def initialize(data, merchant_repo)
    @id = data[:id].to_i
    @name = data[:name]
    @updated_at = data[:updated_at]
    @created_at = data[:created_at]
    @merchant_repo = merchant_repo
  end

  def items
    @merchant_repo.items_for_a_merchant(id)
  end

  def invoices
    @merchant_repo.invoices_for_merchant(id)
  end

  def change_update_time
    @updated_at = Time.now.strftime('%F')
  end

  def change_name(name)
    @name = name
  end

  def revenue
    invoices.map do |invoice|
      invoice.invoice_total(invoice.id)
    end.compact.reduce(0, :+)
  end

  def customers
    invoices = invoices
    invoices.map do |invoice|
      @merchant_repo.find_customer_for_a_merchant(invoice.customer_id)
    end.uniq
  end
end

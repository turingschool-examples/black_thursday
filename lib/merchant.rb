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
    @merchant_repo.sales_engine.items.find_all_by_merchant_id(id)
  end

  def invoices
    @merchant_repo.sales_engine.invoices.find_all_by_merchant_id(id)
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
    end.compact.reduce(0, :+).to_f
  end

  def customers
    invoices = @merchant_repo.sales_engine.invoices.find_all_by_merchant_id(id)
    invoices.map do |invoice|
      @merchant_repo.sales_engine.customers.find_by_id(invoice.customer_id)
    end.uniq
  end
end

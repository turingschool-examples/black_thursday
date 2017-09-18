require_relative "merchant_repository"

class Merchant

  attr_reader :id, :name, :merchant_repository

  def initialize(merchant_repository, csv_info)
    @id = csv_info[:id].to_i
    @name = csv_info[:name]
    @merchant_repository = merchant_repository
  end

  def items
    merchant_repository.sales_engine.items.find_all_by_merchant_id(id)
  end

  def invoices
    merchant_repository.sales_engine.invoices.find_all_by_merchant_id(id)
  end

  def customers
    invoice_array = merchant_repository.sales_engine.invoices.find_all_by_merchant_id(id)
    customer_ids = invoice_array.map {|invoice| invoice.customer_id}
    customer_ids.uniq.map do |customer_id|
      merchant_repository.sales_engine.customers.find_by_id(customer_id)
    end
  end

end

class Merchant
  attr_reader :id, :name, :created_at, :merchant_repository

  def initialize(info = {}, merchant_repository = "")
    @id = info[:id].to_i
    @name = info[:name]
    @created_at = info[:created_at]
    @merchant_repository = merchant_repository
  end

  def created_at
    Time.parse(@created_at)
  end

  def items
    merchant_repository.engine.items.find_all_by_merchant_id(id)
  end

  def invoices
    merchant_repository.engine.invoices.find_all_by_merchant_id(id)
  end

  def customers
    invoices.map { |invoice| invoice.customer_id }.uniq.map do |customer_id|
      merchant_repository.engine.customers.find_by_id(customer_id)
    end
  end

  def any_pending?
    invoices.any? { |invoice| !invoice.is_paid_in_full?}
  end

  def only_one_item?
    items.count == 1
  end

  def revenue

    if invoices.any?
      invoices.select do |invoice|
        invoice.is_paid_in_full?
      end.map {|invoice| invoice.total}.reduce(:+)
    end
  end

end

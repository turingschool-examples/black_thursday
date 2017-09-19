class Merchant

  attr_reader :id, :name, :engine

  def initialize(merchant_info, engine)
    @id = merchant_info[:id].to_i
    @name = merchant_info[:name]
    @engine = engine
  end

  def items
    @engine.items.find_all_by_merchant_id(@id)
  end

  def invoices
    @engine.invoices.find_all_by_merchant_id(@id)
  end

  def customers
    merchant_invoices = invoices
    customer_ids = merchant_invoices.map {|invoice| invoice.customer_id}
    customers = customer_ids.map do |customer_id|
      @engine.customers.find_by_id(customer_id)
    end
    customers.uniq
  end

  def inspect
    "#<#{self.class} #{@items.size} rows>"
  end


end

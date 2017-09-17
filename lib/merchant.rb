class Merchant
  attr_reader :id, :name, :sales_engine
  # attr_accessor :items

  def initialize(info, merchant_repository)
    @id = info[:id].to_i
    @name = info[:name]
    @merchant_repository = merchant_repository
    # @items = []
  end

  def items
    @merchant_repository.find_all_by_merchant_id_in_item_repo(@id)
  end

  def invoices
    @merchant_repository.find_all_by_merchant_id_in_invoice_repo(@id)
  end

  def customers
    invoices.select do |invoice|
      @merchant_repository.find_all_customers(invoice.customer_id)
    end
#this is returning an invoice object because of the select. it is going through invoices and selecting the one that meets the criteria...
#we need to go through the invoices and select the customer object that matches the criteria...
  end

end

module InvoiceHelper
  def find_all_by_customer_id(input)
    @repository.values.find_all do |invoice|
      invoice.customer_id == input
    end
  end

  def find_all_by_status(input)
    @repository.values.find_all do |invoice|
      invoice.status == input
    end
  end
end
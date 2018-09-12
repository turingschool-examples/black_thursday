require_relative './data_repository'
require_relative './invoice'

class InvoiceRepository < DataRepository
  include FindAllByMerchantID

  def initialize(data)
    super(data, Invoice)
  end

  def invoices
    return @data_set.values
  end

  def find_all_by_status(status)
    @data_set.values.find_all do |element|
      element.status == status
    end
  end

  def find_all_by_customer_id(customer_id)
    @data_set.values.find_all do |element|
      element.customer_id == customer_id
    end
  end

end

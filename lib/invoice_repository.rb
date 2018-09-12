require_relative './data_repository'
require_relative './item'

class InvoiceRepository < DataRepository
  def initialize(data)
    super(data, Invoice)
  end
end

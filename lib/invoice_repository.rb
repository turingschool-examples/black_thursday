require 'csv'
require_relative './find_methods'
class InvoiceRepository
  include FindMethods
  def initialize(data)
    @collection = data
  end
end

require 'csv'
require_relative '../lib/invoice'
require_relative './find_methods'
class InvoiceRepository
  include FindMethods
  def initialize(data)
    @collection = data
  end
end

# require_relative '../lib/invoice'
require_relative '../lib/data_access'
require_relative '../lib/item_data_access'

class Customer
  include ItemDataAccess
  include DataAccess

  attr_reader :id, :first_name, :last_name, :created_at, :updated_at

  def initialize(data, parent=nil)
    @id  = data[:id]
    @first_name = data[:first_name]
    @last_name = data[:last_name]
    @created_at  = data[:created_at]
    @updated_at = data[:updated_at]
    @parent = parent
  end

  def merchants
    invoices = parent.parent.invoices.find_all_by_customer_id(id)
    invoices.map { |invoice| invoice.merchant_id }
  end

end
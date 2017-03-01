require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'item'
require_relative 'csv_parser'
require_relative 'merchant'
require_relative 'invoice_repository'
require_relative 'invoice_item'
require_relative 'invoice_item_repository'
require_relative 'transaction'
require_relative 'transaction_repository'
require_relative 'customer'
require_relative 'customer_repository'

class Customer

  attr_reader :id,
              :first_name,
              :last_name,
              :created_at,
              :updated_at,
              :parent

  def initialize(data, parent)
    @id = data[:id].to_i
    @first_name = data[:first_name]
    @last_name = data[:last_name]
    @created_at = Time.parse(data[:created_at])
    @updated_at = Time.parse(data[:updated_at])
    @parent = parent
  end
end
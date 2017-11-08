require 'csv'
require 'pry'

class Merchant

  attr_reader :name, :repository, :id, :created_at, :updated_at

  def initialize(data, repository)
    @name = data[:name]
    @id = data[:id].to_i
    @created_at = Time.parse(data[:created_at])
    @updated_at = Time.parse(data[:updated_at])
    @repository = repository
  end

  def items
    repository.find_item(@id)
  end

  def invoices
    repository.invoices(@id)
  end

  def customers
    repository.find_customers_by_merchant_id(@id)
  end
end

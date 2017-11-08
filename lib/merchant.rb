require 'csv'
require 'pry'

class Merchant

  attr_reader :name, :repository, :id

  def initialize(data, repository)
    @name = data[:name]
    @id = data[:id].to_i
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

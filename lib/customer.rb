require_relative '../lib/sales_engine'
require_relative '../lib/repository'
require 'time'

class Customer
  attr_reader :id,
              :first_name,
              :last_name,
              :created_at,
              :updated_at,
              :repo

  def initialize(row, repo)
    @id = row[:id].to_i
    @first_name = row[:first_name]
    @last_name = row[:last_name]
    @created_at = Time.parse(row[:created_at])
    @updated_at = Time.parse(row[:updated_at])
    @repo = repo
  end


  def invoices
    repo.sales_engine.invoices.find_all_by_customer_id(self.id)
  end

  def merchants
    invoices.map { |invoice| invoice.customer }
  end

end

require_relative 'invoice'
require 'csv'

class InvoiceRepository
  attr_reader :repository
  def initialize(data)
    @repository = {}
    load_csv_file(data)
  end

  def load_csv_file(data)
    CSV.foreach(data, :headers => true, :header_converters => :symbol, :converters => :all) do |row|
      data = row.to_h
      repository[data[:id].to_i] = Invoice.new(data)
    end
  end

  def all
    repository.values
  end

  def find_by_id(id)
    if repository.keys.include?(id)
      return repository[id]
    end
  end

  def find_all_by_customer_id(customer_id)
    items = repository.values
    items.find_all do |item|
      item.customer_id == customer_id
    end
  end

  def find_all_by_merchant_id(merchant_id)
    items = repository.values
    items.find_all do |item|
      item.merchant_id == merchant_id
    end
  end
end

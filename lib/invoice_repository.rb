require 'csv'
require_relative 'invoice'

class InvoiceRepository
  attr_reader :all

  def initialize(path)
    @all = []
    create_invoice(path)
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

  def create_invoice(path)
    CSV.foreach(path, headers: true, header_converters: :symbol) do |invoice|
    @all << Invoice.new(invoice, self)
    end
  end

  def find_by_id(id)
    @all.find do |invoice|
      invoice.id == id
    end
  end

  def find_all_by_customer_id(customer_id)
    # require "pry"; binding.pry
    @all.select do |invoice|
      invoice.customer_id == customer_id
    end
  end

  def find_all_by_merchant_id(merchant_id)
    # require "pry"; binding.pry
    @all.select do |invoice|
      invoice.merchant_id == merchant_id
    end
  end


end

require 'CSV'
require './lib/invoice'

class InvoiceRepository
  attr_reader :all

  def initialize(filepath)
    @filepath = filepath
    @all = []
      CSV.foreach(@filepath, headers: true, header_converters: :symbol) do |row|
        @all << Invoice.new(id: row[:id], customer_id: row[:customer_id], merchant_id: row[:merchant_id], status: row[:status], created_at: row[:created_at], updated_at: row[:updated_at])
      end
    end

  def find_by_id(id)
    @all.find do |invoice|
      invoice.id == id
    end
  end

  def find_all_by_customer_id(customer_id)
    customer_id_array = []
    @all.find_all do |invoice|
      if invoice.customer_id == customer_id
        customer_id_array << invoice
      end
    end
    customer_id_array
  end

  def find_all_by_merchant_id(merchant_id)
    merchant_id_array = []
    @all.find_all do |invoice|
      # require "pry"; binding.pry
      if invoice.merchant_id == merchant_id
        merchant_id_array << invoice
      end
    end
    merchant_id_array
  end

  def find_all_by_status(status)
  status_array =  @all.find_all do |invoice|
    invoice.status == status
    end
  end

  def create(attributes)
    new_invoice = @all.max_by { |invoice| invoice.id }.id + 1
      attributes[:id] = new_invoice
        @all << Invoice.new(attributes)
        return @all.last
  end

  def update(id, attributes)
    if find_by_id(id) != nil
      find_by_id(id).update(attributes)
    end
  end

  def delete(id)
    @all.delete_if do |invoice|
      invoice.id == id
    end
  end
end

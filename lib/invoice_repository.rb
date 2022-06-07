require 'csv'
require_relative '../lib/invoice'
require_relative '../lib/merchant'
require 'pry'
class InvoiceRepository

  attr_reader :all, :file_path


  def initialize(file_path)
    @file_path = file_path
    @all = []

    CSV.foreach(@file_path, headers: true, header_converters: :symbol) do |row|
      @all << Invoice.new({:id => row[:id].to_i, :customer_id => row[:customer_id].to_i, :merchant_id => row[:merchant_id].to_i, :status => row[:status], :created_at => row[:created_at], :updated_at => row[:updated_at]})
    end
  end

  def find_by_id(id)
    @all.find do |invoice|
      if invoice.id == id
        return invoice
      end
    end
  end

  def find_all_by_customer_id(id)
    @all.find_all do |customer|
      customer.customer_id == id
    end
  end
#
  def find_all_by_merchant_id(id)
    matching_id = []
    @all.find_all do |merchant|
      if merchant.merchant_id == id
        matching_id << merchant
        return matching_id
      end
    end
  end
#
  def find_all_by_status(status)
    @all.find_all do |invoice|
      invoice.status == status
    end
  end

  def create(attributes)
    new_id = attributes[:id] = @all.last.id + 1
    @all << Invoice.new({:id => new_id, :customer_id => attributes[:customer_id].to_i, :merchant_id => attributes[:merchant_id].to_i, :status => attributes[:status].to_s, :created_at => attributes[:created_at], :updated_at => attributes[:updated_at]})
  end
#
#
  def update(id, attributes)
    invoice = find_by_id(id)
    if attributes[:status] == "shipped".downcase  || "pending".downcase || "returned".downcase
    invoice.status = attributes[:status]
    end

  end
#
  def delete(id)
    invoice = find_by_id(id)
    @all.delete(invoice)

  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end
end

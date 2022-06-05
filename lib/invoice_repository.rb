require 'CSV'
require "BigDecimal"
require_relative'./invoice.rb'
class InvoiceRepository
  attr_reader :all

  def initialize(invoice_path)
    @invoice_path = invoice_path
    @all = []

    CSV.foreach(@invoice_path, headers: true, header_converters: :symbol) do |row|
    @all << Invoice.new({
      :id => row[:id],
      :customer_id => row[:customer_id],
      :status => row[:status],
      :created_at => row[:created_at],
      :updated_at => row[:updated_at],
      :merchant_id => row[:merchant_id]})
    end
  end

  def find_by_id(id)
    @all.find do |invoice|
      invoice.id.to_i == id
    end
  end

  def find_all_by_customer_id(customer_id)
    @all.find_all do |invoice|
      customer_id.to_i == invoice.customer_id.to_i
    end
  end

  def find_all_by_merchant_id(merchant_id)
    @all.find_all do |invoice|
      merchant_id.to_i == invoice.merchant_id.to_i
    end
  end

  def find_all_by_status(status)
    @all.find_all do |invoice|
      status == invoice.status
    end
  end

  def create(new_invoice_attributes)
    new_id = @all.last.id.to_i + 1
    new_attribute = new_invoice_attributes
    @all << Invoice.new(:id => new_id.to_s, :customer_id => new_attribute[:customer_id], :merchant_id =>
    new_attribute[:merchant_id], :status => "pending", :created_at => Time.now, :updated_at => Time.now)
    return @all.last
  end

  def update(id, attributes)
    updated_item = find_by_id(id)
    updated_item.status = attributes[:status]
    updated_item.updated_at = Time.now
  end
end

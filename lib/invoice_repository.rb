# Frozen_string_literal: true

require 'CSV'
require_relative 'invoice'
# Item Repository
class InvoiceRepository
  attr_reader :contents,
              :parent


  def initialize(path, parent)
    @contents = {}
    @parent = parent
    load_path(path)
  end

  def load_path(path)
    CSV.foreach path, headers: true, header_converters: :symbol do |row|
      @contents[row[:id].to_i] = Invoice.new(row, self)
    end
  end

  def all
    @contents.values
  end

  def find_by_id(id)
    @contents[id]
  end

  def find_all_by_customer_id(customer_id)
    all.find_all { |invoice| invoice.customer_id.to_i == customer_id }
  end

  def find_all_by_merchant_id(merchant_id)
    all.find_all { |invoice| invoice.merchant_id == merchant_id }
  end

  def find_all_by_status(status)
    all.find_all { |invoice| invoice.status == status }
  end

  def create(attributes)
    max_id = @contents.keys.max + 1
    attributes[:id] = max_id
    attributes[:created_at] = Time.now
    @contents[:max] = Invoice.new(attributes, self)
  end

  def update(id, attributes)
    @contents[id] = attributes
  end

  def delete(id)
    @contents.delete(id)
  end

  def merchant_invoice(id)
    parent.merchant_invoice(id)
  end

  def inspect
  "#<#{self.class} #{@contents.size} rows>"
  end
end

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

  def find_all_by_customer_id(name)
    all.find { |item| item.name.downcase == name.downcase }
  end

  def find_all_with_description(description)
    all.find_all do |invoice|
      invoice.description.downcase.include?(description.downcase)
    end
  end

  def find_all_by_price(price)
    all.find_all do |invoice|
      invoice.unit_price_to_dollars == price
    end
  end

  def find_all_by_price_in_range(range)
    all.find_all do |invoice|
      range.include?(invoice.unit_price_to_dollars)
    end
  end

  def find_all_by_merchant_id(merchant_id)
    all.find_all { |invoice| invoice if invoice.merchant_id == merchant_id }
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

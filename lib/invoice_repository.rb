require './lib/invoice'
require 'bigdecimal'
require 'bigdecimal/util'
require 'time'
require "csv"

class InvoiceRepository
  attr_reader :filename,
              :parent,
              :invoices

  def initialize(filename, parent)
    @filename = filename
    @parent = parent
    @invoices = Array.new
    generate_invoices(filename)
  end

  def inspect
    "#<#{self.class} #{@invoices.size} rows>"
  end

  def generate_invoices(filename)
    invoices = CSV.open filename, headers: true, header_converters: :symbol
    invoices.each do |row|
      @invoices << Invoice.new(row, self)
    end
  end

  def all
    @invoices
  end

  def find_by_id(id)
    @invoices.find do |invoice|
      invoice.id.to_i == id
    end
  end

  def find_all_by_customer_id(customer_id)
   customer_found = []
    @invoices.find_all do |invoice|
      customer_found << invoice if invoice.customer_id.to_i == customer_id
    end
    customer_found
  end

  def find_all_by_merchant_id(merchant_id)
   merchant_found = []
    @invoices.find_all do |invoice|
      # require "pry"; binding.pry
      merchant_found << invoice if invoice.merchant_id.to_i == merchant_id
    end
    merchant_found
  end

  # def find_by_name(name)
  #   @items.find do |item|
  #     item.name == name
  #   end
  # end

  # def find_all_with_description(description)
  #   @items.find_all do |item|
  #     item.description.downcase == description.downcase
  #   end
  # end
  #
  # def find_all_by_price(price)
  #   @items.find_all do |item|
  #     item.unit_price == price
  #   end
  # end
  #
  # def find_all_by_price_in_range(range)
  #   @items.find_all do |item|
  #     range.include?(item.unit_price)
  #   end
  # end
  #
  # def find_all_by_merchant_id(merchant_id)
  #   @invoice.find_all do |invoice|
  #     invoice.merchant_id == merchant_id.to_s
  #   end
  # end
  #
  # def create(attributes)
  #   id = @items[-1].id.to_i
  #   id += 1
  #   id = id.to_s
  #   attributes[:id] = id
  #   attributes[:unit_price]
  #   item = Item.new(attributes, self)
  #   @items.push(item)
  # end
  #
  # def update(id, attributes)
  #   update_item = find_by_id(id)
  #   update_item.update(attributes) if !attributes[:name].nil?
  #   update_item.update(attributes) if !attributes[:description].nil?
  #   update_item.update(attributes) if !attributes[:unit_price].nil?
  #   update_item
  # end
  #
  # def delete(id)
  #   delete = find_by_id(id)
  #   @items.delete(delete)
  # end
end

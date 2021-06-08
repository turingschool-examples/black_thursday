require 'csv'
require 'bigdecimal'
require 'time'
require_relative 'invoice_item'

class InvoiceItemRepository
  attr_reader :all

  def initialize(path)
    @all = []
    create_invoice_items(path)
  end

  # :nocov:
  def inspect
    "#<#{self.class} #{@invoice_items.size} rows>"
  end
  # :nocov:

  def create_invoice_items(path)
    CSV.foreach(path, headers: true, header_converters: :symbol).each do |invoice_item|
      @all << InvoiceItem.new(invoice_item, self)
    end
  end

  def find_by_id(id)
    @all.find do |item|
      item.id == id
    end
  end

  def find_all_by_item_id(id)
    @all.find_all do |item|
      item.item_id == id
    end
  end

  def find_all_by_invoice_id(id)
    @all.find_all do |item|
      item.invoice_id == id
    end
  end

  def new_invoice_item_id
    invoice_item = @all.max_by { |item| item.id }
    invoice_item.id + 1
  end

  def create(attributes)
    @all << InvoiceItem.create_invoice_item(attributes, self)
  end

  def update(id, attributes)
    unless find_by_id(id).nil?
      find_by_id(id).update_invoice_item(attributes)
    end
  end

  def delete(id)
    @all.delete(find_by_id(id))
  end

  def find_unit_price_by_date(date)
    @all.find_all do |invoice_item|
      invoice_item.created_at == Time.parse(date)
    end
  end

  def total_unit_price_by_invoice_id
    invoice_id_to_price = Hash.new{|hash, key| hash[key] = Array.new}
    @all.each do |invoice_item|
      invoice_id_to_price[invoice_item.invoice_id] << invoice_item.unit_price
    end
    invoice_id_to_price.each do |invoice_id, unit_price|
      invoice_id_to_price[invoice_id] = unit_price.sum
    end
    invoice_id_to_price
  end
end

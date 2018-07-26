require 'csv'
require_relative '../lib/invoice_item.rb'
require_relative '../lib/repo_method_helper.rb'
require 'pry'

class InvoiceItemRepository
  attr_reader :invoice_items
  include RepoMethodHelper

  def initialize(invoice_item_location)
    @invoice_item_location = invoice_item_location
    @invoice_items = []
    from_sales_engine
  end

  def from_sales_engine
    CSV.foreach(@invoice_item_location, headers: true, header_converters: :symbol) do |row|
      @invoice_items << InvoiceItem.new(row)
    end
  end

  def all
    @invoice_items
  end

  def find_all_by_item_id(item_id)
    @invoice_items.find_all do |invoice_item|
      invoice_item.item_id == item_id
    end
  end

  def find_all_by_invoice_id(invoice_id)
    @invoice_items.find_all do |invoice_item|
      invoice_item.invoice_id == invoice_id
    end
  end

  def create(attributes)
    attributes[:id] = create_id
    attributes[:created_at] = Time.now.to_s
    attributes[:updated_at] = Time.now.to_s
    created = InvoiceItem.new(attributes)
    @invoice_items << created
    created
  end

  # def update(id, attributes)
  #   find_by_id(id).name = attributes[:name] unless attributes[:name].nil?
  #   find_by_id(id).description = attributes[:description] unless attributes[:description].nil?
  #   find_by_id(id).unit_price = attributes[:unit_price] unless attributes[:unit_price].nil?
  #   find_by_id(id).updated_at = Time.now unless find_by_id(id).nil?
  # end

  def inspect
    "#<#{self.InvoiceItemRepository} #{@invoice_items.size} rows>"
  end
end

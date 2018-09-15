require 'csv'
require 'bigdecimal'
require 'time'
require_relative './repository_module'

class InvoiceItemRepository

  include RepoMethods

  def initialize(filepath = nil)
    @filepath = filepath
    @all = []
    split(filepath) if filepath != nil
  end

  def create(attributes)
    is_included = @all.any? do |invoice_item|
      attributes[:id] == invoice_item.id
    end
    is_included = false if @all == []
    has_id = attributes[:id] != nil
    if has_id && !is_included
      @all << InvoiceItem.new(attributes)
    elsif @all == []
      new_id = 1
      attributes[:id] = new_id
      @all << InvoiceItem.new(attributes)
    else
      highest_id = @all.max_by do |invoice_item|
        invoice_item.id
      end.id
      new_id = highest_id + 1
      attributes[:id] = new_id
      @all << InvoiceItem.new(attributes)
    end
  end

  def split(filepath)
    objects = CSV.open(filepath, headers: true, header_converters: :symbol)
    attributes_array = []
    objects.map do |object|
      object[:id] = object[:id].to_i

      object[:item_id] = object[:item_id].to_i

      object[:invoice_id] = object[:invoice_id].to_i

      object[:unit_price] = BigDecimal.new(object[:unit_price]) / 100

      object[:quantity] = object[:quantity].to_i

      object[:created_at] = Time.parse(object[:created_at])

      object[:updated_at] = Time.parse(object[:updated_at])

      attributes_array << object.to_h
    end
    attributes_array.each do |hash|
      create(hash)
    end
  end

  def find_all_by_item_id(items_id)
    @all.find_all do |invoice_item|
      invoice_item.item_id == items_id
    end
  end

  def find_all_by_invoice_id(invoices_id)
    @all.find_all do |invoice_item|
      invoice_item.invoice_id == invoices_id
    end
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

end

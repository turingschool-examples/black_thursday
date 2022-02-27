require 'pry'
require 'csv'
require_relative 'invoice_item'

class InvoiceItemRepository

  attr_reader :invoice_items

  def initialize(data)
    @invoice_items =[]
    CSV.foreach(data, headers: true, header_converters: :symbol) do |row| header ||= row.headers
    @invoice_items << InvoiceItem.new(row)
  end

  def inspect
    "#<\#{self.class} \#{@invoice_items.size} rows>"
  end

  def all
    @invoice_items
  end

  def find_by_id(id)
    item_found = @invoice_items.find {|item| item.id == id}
  end

def find_by_item_id(item_id)
  @invoice_items.find {|item| item.item_id == item_id }
end

def find_all_with_description(description)
  @items.find_all {|item| item.description.downcase.include?(description.downcase)}
end

def find_all_by_price(price)
  @items.find_all {|item| item.unit_price == BigDecimal(price)}
end

def find_all_by_price_in_range(range)
  @items.find_all {|item| range.include?(item.unit_price)}
end

def find_all_by_merchant_id(merchant_id)
  @items.find_all {|item| item.merchant_id == merchant_id}
end

def create(attributes)
  attributes[:id] = @items.last.id + 1
  attributes[:created_at] = Time.now.to_s
  attributes[:updated_at] = Time.now.to_s
  new_item = Item.new(attributes)
  @items << new_item
  new_item
end

def update(id, attributes)
  item_to_update = find_by_id(id)
  if item_to_update != nil
      attributes.each do |key, value|
        if ![:id, :created_at, :merchant_id].include?(key)
          item_to_update.info[key.to_sym] = value
          item_to_update.info[:updated_at] = (Time.now + 1).to_s
        end
      end
  end
  item_to_update
end

def delete(id)
  @items.delete(find_by_id(id)) if find_by_id(id) != nil
end
end

require 'pry'

require_relative 'finderclass'

require_relative 'invoice_item'


class InvoiceItemRepository

  attr_reader :all

  def initialize(data)
    @data = data
    @invoice_items = []
    make_invoice_items
    @all = @invoice_items
  end


  def make_invoice_items(data = @data)
    data.each { |key, value|
      hash = make_hash(key, value)
      item = InvoiceItem.new(hash)
      @invoice_items << item
    }
  end

  def make_hash(key, value)
    hash = {id: key.to_s.to_i}
    value.each { |col, data| hash[col] = data }
    return hash
  end



  # --- Spec Harness Requirement ---

  # TO DO - TEST ME
  def inspect
    "#<#{self.class} #{@all.size} rows>"
  end


  # --- Find By ---

  def find_by_id(id)
    FinderClass.find_by(all, :id, id)
  end

  def find_all_by_item_id(item_id)
    FinderClass.find_all_by(all, :item_id, item_id)
  end

  def find_all_by_invoice_id(invoice_id)
    FinderClass.find_all_by(all, :invoice_id, invoice_id)
  end


  # --- CRUD ---

  def create(hash)
    last = FinderClass.find_max(all, :id)
    new_id = last.id + 1
    hash[:id] = new_id
    invoice_item = InvoiceItem.new(hash)
    @invoice_items << invoice_item
    return invoice_item
  end

  def update(id, hash)
    item = find_by_id(id)
    item.make_update(hash) if item
  end

  def delete(id)
    @invoice_items.delete_if{ |item| item.id == id }
  end

end

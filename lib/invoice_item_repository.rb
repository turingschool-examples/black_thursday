require 'csv'
require_relative 'repository'
require_relative 'invoice_item'
require 'time'

class InvoiceItemRepository < Repository
  def initialize(location_hash, engine)
    super(location_hash, engine)
    all_invoice_items
  end

  def all_invoice_items
    @csv_array = []
    CSV.parse(File.read(@location_hash[:invoice_items]), headers: true).each do |invoice_item|
      @csv_array << InvoiceItem.new(
        id: invoice_item[0],
        item_id: invoice_item[1],
        invoice_id: invoice_item[2],
        quantity: invoice_item[3],
        cent_price: invoice_item[4],
        created_at:  Time.parse(invoice_item[5]),
        updated_at:  Time.parse(invoice_item[6]),
        repository:  self
      )
    end
  end

  def find_all_by_item_id(item_id)
    @csv_array.find_all do |invoice_item|
      invoice_item.item_id == item_id
    end
  end

  def find_all_by_invoice_id(invoice_id)
    @csv_array.find_all do |invoice_item|
      invoice_item.invoice_id == invoice_id
    end
  end

  def create(invoice_item_hash)
    attributes = {
      id: max_id_number_new,
      item_id: invoice_item_hash[:item_id].to_i,
      invoice_id: invoice_item_hash[:invoice_id].to_i,
      quantity: invoice_item_hash[:quantity].to_i,
      cent_price: invoice_item_hash[:unit_price] * 100,
      created_at: Time.now,
      updated_at: Time.now,
      repository: self
    }
    @csv_array << InvoiceItem.new(attributes)
    InvoiceItem.new(attributes)
  end

  def update(id, attributes)
    update_instance = find_by_id(id)
    if !update_instance.nil?
      update_instance.quantity = attributes[:quantity] unless attributes[:quantity].nil?
      update_instance.cent_price = BigDecimal(attributes[:unit_price] * 100, 10) unless attributes[:unit_price].nil?
      update_instance.updated_at = Time.now
    end
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
    # should this be @merchants or @invoices
    # same with item repo
  end
end

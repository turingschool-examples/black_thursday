require_relative 'invoice_item'
require 'csv'
require 'pry'

class InvoiceItemRepository

  attr_reader :sales_engine,
              :file_path,
              :id_repo

  def initialize(file_path, sales_engine)
    @file_path    = file_path
    @sales_engine = sales_engine
    @id_repo       = {}
    load_repo
  end

  def load_repo
    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      invoice_item_identification = row[:id]
      invoice_item = InvoiceItem.new(row, self)
      id_repo[invoice_item_identification.to_i] = invoice_item
    end
  end

  def all
    id_repo.map do |id, invoice_item_info|
      invoice_item_info
    end
  end

  def find_by_id(id)
    id_repo[id]
  end

  def find_all_by_item_id(item_id)
    id_repo.values.select do |invoice_item_instance|
      invoice_item_instance.item_id == item_id
    end
  end

  def find_all_by_invoice_id(invoice_id)
    id_repo.values.select do |invoice_item_instance|
      invoice_item_instance.invoice_id == invoice_id
    end
  end

  def inspect
    "#<#{self.class} #{@invoice_items.size} rows>"
  end

end

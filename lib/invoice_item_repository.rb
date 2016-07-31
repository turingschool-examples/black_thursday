require_relative "../lib/invoice_item"
require "csv"
require 'pry'

class InvoiceItemRepository
attr_reader :all

  def initialize(data_path, sales_engine = nil)
    @sales_engine = sales_engine
    @all = []
    csv_loader(data_path)
    item_maker
  end

  def csv_loader(data_path)
    @csv = CSV.open data_path, headers:true, header_converters: :symbol
  end

  def item_maker
    @all = @csv.map do |row|
      InvoiceItem.new(row, self)
    end
  end

  def find_by_id(id_input)
    @all.find do |instance|
      instance.id == id_input.to_i
    end
  end

  def find_all_by_price(price)
    @all.find_all do |instance|
      instance.unit_price == (price)
    end
  end

  def find_all_by_item_id(item_id_input)
    @all.find_all do |instance|
      instance.item_id == item_id_input.to_i
    end
  end


  def find_all_by_invoice_id(invoice_id_input)
    @all.find_all do |instance|
      instance.invoice_id == invoice_id_input.to_i
    end
  end



  def inspect
  end
end

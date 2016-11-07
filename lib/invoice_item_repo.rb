require_relative '../lib/invoice_item'
require 'csv'
require 'pry'

class InvoiceItemRepo

  attr_reader :all,
              :id,
              :item_id,
              :invoice_id,
              :quantity,
              :unit_price,
              :created_at,
              :updated_at

  def initialize(file, sales_engine)
    @parent = sales_engine
    @all = []
    file_reader(file)
  end

 def file_reader(file)
    contents = CSV.open(file, headers:true, header_converters: :symbol)
    contents.each do |item|
       @all << InvoiceItem.new(item, self)
    end
  end

  def find_by_id(desired_id)
    @all.find do |invoice|
      invoice.id == desired_id
    end
  end

  def find_all_by_item_id(item_id)
    @all.find_all do |invoice|
      invoice.item_id == item_id.to_i
    end
  end
  
  def find_all_by_invoice_id(invoice_id)
    @all.find_all do |invoice|
      invoice.invoice_id == invoice_id.to_i
    end
  end
end
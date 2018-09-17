require_relative './invoice_item'
require_relative './repo_methods'
require 'time'
require 'pry'

class InvoiceItemRepository
  include RepoMethods
  attr_reader :objects_array

  def initialize(file_path)
    @objects_array = invoice_item_csv_converter(file_path)
  end

  def invoice_item_csv_converter(file_path)
    csv_objs = CSV.read(file_path, {headers: true, header_converters: :symbol})
    csv_objs.map do |obj|
      obj[:id] = obj[:id].to_i
      obj[:item_id] = obj[:item_id].to_i
      obj[:invoice_id] = obj[:invoice_id].to_i
      obj[:quantity] = obj[:quantity].to_i
      obj[:unit_price] = BigDecimal.new(obj[:unit_price])/100
      obj[:updated_at] = Time.parse(obj[:updated_at])
      obj[:created_at] = Time.parse(obj[:created_at])
      InvoiceItem.new(obj.to_h)
    end
  end

  # def inspect
  #   "#<#{self.class} #{@objects_array.size} rows>"
  # end

  def find_all_by_item_id(id)
    @objects_array.find_all do |invoice_item|
      invoice_item.item_id == id
    end
  end

  def create(attributes)
    max_id = generate_id
    time = attributes[:created_at].getutc
    attributes = {:id => max_id,
                  :item_id => attributes[:item_id],
                  :invoice_id => attributes[:invoice_id],
                  :quantity => attributes[:quantity],
                  :unit_price => attributes[:unit_price],
                  :created_at => time,
                  :updated_at => time }
    @objects_array << InvoiceItem.new(attributes)
  end

  def update(id, attributes)
    invoice_item = find_by_id(id)
    if attributes[:quantity].class == Fixnum
      invoice_item.updated_at = Time.now
      invoice_item.quantity = attributes[:quantity]
    else
      "Not a valid entry"
    end
  end
end

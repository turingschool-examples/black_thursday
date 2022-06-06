require 'CSV'
require_relative "merchant"
require_relative "invoice"
require_relative "item"
require_relative "invoice_item"
require_relative '../modules/findable'
require_relative '../modules/changeable'

class InvoiceItemRepository

  attr_reader :all
  include Findable
  include Changeable

  def initialize(file_path)
    @file_path = file_path
    @all = []
    CSV.foreach(@file_path, headers: true, header_converters: :symbol) do |row|
      @all << InvoiceItem.new(row)
    end
  end

  def create(attributes)
    attributes[:id]= find_max_id + 1
    @all << InvoiceItem.new(attributes)
  end

  def update(id, attributes)
    invoice_item = find_by_id(id)
    if invoice_item == nil
      exit
    else
      invoice_item.quantity = attributes[:quantity]
    end
    find_by_id(id).updated_at = Time.now if find_by_id(id).class == InvoiceItem
  end

  def inspect
   "#<#{self.class} #{@merchants.size} rows>"
  end

end

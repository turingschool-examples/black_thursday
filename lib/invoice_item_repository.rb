require 'csv'
require_relative '../lib/invoice_item'
require_relative '../lib/create_elements'

class InvoiceItemRepository

  include CreateElements

  attr_reader :invoice_items, :engine

  def initialize(items_file, engine)
    @invoice_items      = create_elements(items_file).map {|item_invoice| InvoiceItem.new(item_invoice, self)}
    @engine = engine
  end

  def all
    return invoice_items
  end
  #
  # def count
  #   merchants.count
  # end
  #
  # def find_by_name(name)
  #   merchants.find do |merchant|
  #     merchant.name.downcase == name.downcase
  #   end
  # end

  def inspect
      "#<#{self.class} #{@invoice_items.size} rows>"
  end

end

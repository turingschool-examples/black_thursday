require 'csv'
require_relative 'invoice_item'
require_relative 'methodable'

class InvoiceItemRepository
  include Methodable
  attr_reader :all

  def initialize(filepath)
    @filepath = filepath
    @all = []
    CSV.foreach(@filepath, headers: true, header_converters: :symbol) do |row|
      @all << InvoiceItem.new(row)
    end
  end

  # def find_by_id(id)
  #   @all.find { |invoiceitem| invoiceitem.id == id }
  # end

  def find_all_by_item_id(item_id)
    @all.find_all { |invoiceitem| invoiceitem.item_id == item_id }
  end

  def find_all_by_invoice_id(invoice_id)
    @all.find_all { |invoiceitem| invoiceitem.invoice_id == invoice_id }
  end

  def create(attributes)
    attributes[:id] = @all.max_by { |invoiceitem| invoiceitem.id }.id + 1
    @all << InvoiceItem.new(attributes)
    @all.last
  end

  # def update(id, attributes)
  #   if find_by_id(id)
  #     find_by_id(id).update(attributes)
  #   end
  # end

  def delete(id)
    @all.delete_if { |invoiceitem| invoiceitem.id == id }
  end

  # def inspect
  #   "#<#{self.class} #{@merchants.size} rows>"
  # end
end

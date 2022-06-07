require 'CSV'
require 'BigDecimal'
require_relative './invoice_item.rb'

class InvoiceItemRepository
  attr_reader :all
  def initialize(invoice_item_path)
    @invoice_item_path = invoice_item_path
    @all = []

    CSV.foreach(@invoice_item_path, headers: true, header_converters: :symbol) do |row|
    @all << InvoiceItem.new({
      :id => row[:id],
      :item_id => row[:item_id],
      :invoice_id => row[:invoice_id],
      :quantity => row[:quantity],
      :unit_price => row[:unit_price],
      :created_at => row[:created_at],
      :updated_at => row[:updated_at],
      :unit_price => row[:unit_price]
      })
		end

  end

  def find_by_id(id)
		@all.find do |invoice_item|
			invoice_item.id.to_i == id
		end
	end

  def find_all_by_item_id(item_id)
		@all.find_all do |invoice_item|
			invoice_item.item_id == item_id
		end
	end

  def find_all_by_invoice_id(invoice_id)
		@all.find_all do |invoice_item|
			invoice_item.invoice_id.to_i == invoice_id
		end
	end

  def create(new_invoice_attributes)
    new_id = @all.last.id.to_i + 1
    new_attribute = new_invoice_attributes
    @all << InvoiceItem.new(:id => new_id.to_s, :item_id => new_attribute[:item_id], :invoice_id =>
    new_attribute[:invoice_id], :unit_price => new_attribute[:unit_price], :quantity => new_attribute[:quantity], :created_at => Time.now, :updated_at => Time.now)
    return @all.last

  end




end

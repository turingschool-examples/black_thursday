require 'csv'
require 'time'
require_relative './invoice_item'


class InvoiceItemRepository
  attr_accessor :invoice_items_array
  attr_reader :contents, :engine

  def initialize(path, engine = '')
    @invoice_items_path = path
    @invoice_items_array = []
    @engine = engine
    pull_csv
    parse_csv
  end

  def pull_csv
    @contents = CSV.open @invoice_items_path, headers: true,
     header_converters: :symbol
  end

  def parse_csv
    contents.each do |row|
      invoice_items_array << InvoiceItem.new({
        :id         => row[:id].to_i,
        :item_id    => row[:item_id].to_i,
        :invoice_id => row[:invoice_id].to_i,
        :quantity   => row[:quantity].to_i,
        :unit_price => BigDecimal.new(row[:unit_price].to_i) / 100,
        :created_at => Time.parse(row[:created_at]),
        :updated_at => Time.parse(row[:updated_at])
      }, self)
    end
  end

  def all
    invoice_items_array
  end

  def find_by_id(find_id)
    invoice_items_array.find do |instance|
      instance.id == find_id
    end
  end

  def find_all_by_item_id(find_id)
    invoice_items_array.find_all do |instance|
      instance.item_id == find_id
    end
  end

  def find_all_by_invoice_id(invoice_id)
    invoice_items_array.find_all do |instance|
      instance.invoice_id == invoice_id
    end
  end

  def inspect
    "#<#{self.class} #{@invoice_items.size} rows>"
  end
end

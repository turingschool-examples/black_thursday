require 'CSV'
require_relative './invoice_item'
require_relative './cleaner'

class InvoiceItemRepository
  attr_reader :invoice_items

  def initialize(file = './data/invoice_items.csv')
    @file = file
    @ii_csv = CSV.open(@file, headers: true, header_converters: :symbol)
    @invoice_items = []
    @cleaner = Cleaner.new
    ii_objects(@ii_csv)
  end

  def ii_objects(ii_rows)
    ii_rows.each do |row|
      precision      = row[:unit_price].length
      value_adjusted = row[:unit_price].to_i * 0.01
      # A module could hold assignment hashes for all classes
      @invoice_items << InvoiceItem.new({:id       => row[:id].to_i,
                          :item_id        => row[:name],
                          :invoice_id => row[:invoice_id],
                          :quantity    => row[:quantity],
                          :unit_price  => BigDecimal.new(value_adjusted, precision),
                          :created_at  => @cleaner.clean_date(row[:created_at]),
                          :updated_at  => @cleaner.clean_date(row[:updated_at]),
                        })
    end
    @invoice_items
  end

  def all
    @invoice_items
  end
end

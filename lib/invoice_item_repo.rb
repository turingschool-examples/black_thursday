require 'CSV'
require_relative './invoice_item'
require_relative './cleaner'

class InvoiceItemRepository
  def initialize(file = './data/invoice_items.csv')
    @file = file
    @ii_csv = CSV.open(@file, headers: true, header_converters: :symbol)
    @ii_array = []
    ii_objects(@ii_csv)
  end

  def ii_objects(ii_rows)
    ii_rows.each do |row|
      precision = row[:unit_price].to_s.length
      @ii_array << InvoiceItem.new({:id       => row[:id].to_i,
                          :item_id        => row[:name],
                          :description => row[:description],
                          :unit_price  => BigDecimal.new(row[:unit_price]),
                          :created_at  => @cleaner.clean_date(row[:created_at]),
                          :updated_at  => @cleaner.clean_date(row[:updated_at]),
                          :merchant_id => row[:merchant_id].to_i
                        })
    end
    @ii_array
  end

  def all
    @ii_array
  end
end

require 'CSV'
require_relative './invoice_item'
require_relative './cleaner'

class InvoiceItemRepository
  attr_reader :invoice_items

  def initialize(file = './data/invoice_items.csv')
    @file = file
    @ii_csv = CSV.open(@file, headers: true, header_converters: :symbol)
    @invoice_items = Hash.new
    @cleaner = Cleaner.new
    ii_objects(@ii_csv)
  end

  def inspect
    "#<#{self.class} #{@invoice_items.size} rows>"
  end

  def ii_objects(ii_rows)
    ii_rows.each do |row|
      precision      = row[:unit_price].length
      value_adjusted = row[:unit_price].to_i * 0.01
      # A module could hold assignment hashes for all classes
      @invoice_items[row[:id].to_i] = InvoiceItem.new({:id => row[:id].to_i,
                          :item_id        => row[:item_id].to_i,
                          :invoice_id => row[:invoice_id].to_i,
                          :quantity    => row[:quantity].to_i,
                          :unit_price  => BigDecimal.new(value_adjusted, precision),
                          :created_at  => @cleaner.clean_date(row[:created_at]),
                          :updated_at  => @cleaner.clean_date(row[:updated_at]),
                        })
    end
    @invoice_items
  end

  def all
    @invoice_items.values
  end

  def find_by_id(id)
    @invoice_items[id]
  end

  def find_all_by_item_id(id)
    all.select do |ii|
      ii.item_id == id
    end
  end

  def find_all_by_invoice_id(id)
    all.select do |ii|
      ii.invoice_id == id
    end
  end

  def max_id
    @invoice_items.keys.max
  end

  def create(attributes)
    new_id = max_id + 1
    @invoice_items[new_id] = InvoiceItem.new({
      id: new_id,
      item_id: attributes[:item_id],
      invoice_id: attributes[:invoice_id],
      quantity: attributes[:quantity],
      unit_price: attributes[:unit_price],
      created_at: attributes[:created_at],
      updated_at: attributes[:updated_at]
    })
  end

  def update(id, attributes)
    ii = find_by_id(id)
    if ii != nil
      ii.update(attributes)
    end
    ii
  end

  def delete(id)
    @invoice_items.delete(id)
  end

  def invoice_item_revenue_by_invoice_id
    ii_by_invoice_id = {}
    all.each do |ii|
    invoice_revenue = find_all_by_invoice_id(ii.invoice_id).sum do |ii|
          ii.total_price
        end
    ii_by_invoice_id[ii.invoice_id] = invoice_revenue
    end
    ii_by_invoice_id
  end

  def invoice_item_by_invoice_id
    ii_by_invoice_id = {}
    all.each do |ii|
      ii_by_invoice_id[ii.invoice_id] = find_all_by_invoice_id(ii.invoice_id)
    end
    ii_by_invoice_id
  end
end

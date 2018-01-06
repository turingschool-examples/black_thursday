require 'csv'
require 'time'
require_relative '../lib/item'


class ItemRepository

  attr_reader :items_csv,
              :items,
              :se

  def initialize(csv_file, se)
    @items = []
    @se = se
    @invoices = []
    CSV.foreach csv_file, headers: true, header_converters: :symbol do |row|
      @items << Item.new({
        name: row[:name],
        id: row[:id],
        description: row[:description],
        unit_price: row[:unit_price],
        created_at: Time.parse(row[:created_at]),
        updated_at: Time.parse(row[:updated_at]),
        merchant_id: row[:merchant_id],
        item_repo: self
        })
    end
  end

  def inspect
    "#<#{self.class} #{@invoices.size} rows>"
  end

  def all
    @items
  end

  def find_by_id(id)
    @items.find do |item|
      item.id == id
    end
  end

  def find_by_name(name)
    @items.find do |item|
      item.name == name
    end
  end

  def find_all_with_description(description)
    @items.find_all do |item|
      item.description.downcase.include?(description.downcase)
    end
  end

  def find_all_by_price(price) # NEEDS TESTS!!
    @items.find_all do |item|
      item.unit_price == price
    end
  end

  def find_all_by_price_in_range(range) # NEEDS TESTS!!
    @items.find_all do |item|
      item if range.include?(item.unit_price)
    end
  end

  def find_all_by_merchant_id(merchant_id) # NEEDS TESTS!!
    @items.find_all do |item|
      item.merchant_id == merchant_id
    end
  end

  def find_item(id) # NEEDS TESTS!!
    items.find_all do |item|
      item.merchant_id == id
    end
  end

  def find_merchant(id) # NEEDS TESTS!!
    se.find_merchant_by_id(id)
  end

end

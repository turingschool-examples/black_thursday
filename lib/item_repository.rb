require 'csv'
require_relative '../lib/item'

class ItemRepository

  attr_reader :items_csv,
              :items,
              :se

  def initialize(csv_file, se)
    @items_csv = CSV.open csv_file, headers: true, header_converters: :symbol
    @items = []
    @se = se
    items_csv.each do |row|
      id          = row[:id]
      name        = row[:name]
      unit_price  = row[:unit_price]
      created_at  = row[:created_at]
      updated_at  = row[:updated_at]
      description = row[:description]
      merchant_id = row[:merchant_id]
      @items << Item.new({
        name: name,
        id: id,
        description: description,
        unit_price: unit_price,
        created_at: created_at,
        updated_at: updated_at,
        merchant_id: merchant_id,
        item_repo: self
        })
    end
    @invoices = []
  end

  def inspect
    "#<#{self.class} #{@invoices.size} rows>"
  end

  def all
    @items
  end

  def find_by_id(id)
    @items.find do |item|
      item.id if item.id == id
    end
  end

  def find_by_name(name)
    @items.find do |item|
      item.name if item.name == name
    end
  end

  def find_all_with_description(description)
    @items.find_all do |item|
      item if item.description.downcase.include?(description.downcase)
    end
  end

  def find_all_by_price(price) # NEEDS TESTS!!
    @items.find_all do |item|
      item if item.unit_price == price
    end
  end

  def find_all_by_price_in_range(range) # NEEDS TESTS!!
    @items.find_all do |item|
      item if range.include?(item.unit_price)
    end
  end

  def find_all_by_merchant_id(merchant_id) # NEEDS TESTS!!
    @items.find_all do |item|
      item if item.merchant_id == merchant_id
    end
  end

  def find_item(id) # NEEDS TESTS!!
    items.find_all do |item|
      item if item.merchant_id == id
    end
  end

  def find_merchant(id) # NEEDS TESTS!!
    se.find_merchant_by_id(id)
  end

  def total_items # NEEDS TESTS!!
    items.count
  end

  def create_item_list # NEEDS TESTS!!!
    items.map { |item| item }
  end

end

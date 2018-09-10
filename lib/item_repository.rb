require_relative './item'
require_relative './repository'
require 'bigdecimal'

class ItemRepository < Repository

  def initialize(filepath)
    super()
    load_items(filepath)
  end

  def load_items(filepath)
    CSV.foreach(filepath, headers: true, header_converters: :symbol ) do |datum|
      datum[:unit_price] = BigDecimal.new(datum[:unit_price],4)/100
      @data << Item.new(datum)
    end
  end

  def find_all_with_description(description)
    @data.find_all do |datum|
      datum.description.include?(description)
    end
  end

  def find_all_by_price(price)
    @data.find_all do |datum|
      datum.unit_price == price
    end
  end

  def find_all_by_price_range(range)
    @data.find_all do |datum|
      range.include?(datum.unit_price)
    end
  end

  def find_all_by_merchant_id(id)
    @data.find_all do |datum|
      datum.merchant_id == id
    end
  end

  def create(new_item)
    highest_id = @data.max_by do |datum|
      datum.id
    end.id
    new_item_id = highest_id += 1
    new_item = Item.new(id: new_item_id,
                        name: new_item[:name],
                        description: new_item[:description],
                        unit_price: new_item[:unit_price],
                        created_at: Time.now,
                        updated_at: Time.now,
                        merchant_id: new_item[:merchant_id])
    @data << new_item
    return new_item
  end

  def update(id, attributes)
    @data.find do |datum|
      if datum.id == id
      datum.name = attributes[:name]
      datum.description = attributes[:description]
      datum.unit_price = attributes[:unit_price]
      datum.updated_at = Time.now
      end
    end
  end





end

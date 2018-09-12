require 'CSV'

class ItemRepository
attr_reader :items
  def initialize(file_path)
    @items = []
    load_items(file_path)
  end

  def load_items(file_path)
    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      @items << Item.new(row)
    end
  end

  def all
    @items
  end

  def find_by_id(id_number)
    @items.find do |item|
      item.id == id_number
    end
  end

  def find_by_name(name)
    @items.find do |item|
      item.name.downcase == name.downcase
    end
  end

  def find_all_with_description(item_description)
    @items.find_all do |item|
      item.description.downcase.include?(item_description.downcase)
      end
  end

  def find_all_by_price(price)
    @items.find_all do |item|
      item.unit_price == price
    end
  end

  def find_all_by_price_in_range(range)
    @items.find_all do |item|
      range.include?(item.unit_price)
    end
  end

  def find_all_by_merchant_id(id)
    @items.find_all do |item|
      item.merchant_id == id
    end
  end

  def create(attributes)
    attributes[:id] = @items[-1].id + 1
    @items << Item.new(attributes)
  end

  def update(id, attributes)
    item = find_by_id(id)
    item.name = attributes[:name] unless attributes[:name].nil?
    item.description = attributes[:description] unless attributes[:description].nil?
    item.unit_price = attributes[:unit_price] unless attributes[:unit_price].nil?
    item.updated_at = Time.now unless (attributes[:name].nil? && attributes[:description].nil? && attributes[:unit_price].nil?)
    item
    require "pry"; binding.pry
  end

  def delete(id)
    @items.delete(find_by_id(id))
  end

  def inspect
   "#<#{self.class} #{@merchants.size} rows>"
  end
end

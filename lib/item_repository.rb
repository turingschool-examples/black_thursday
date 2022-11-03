require 'bigdecimal'

class ItemRepository
  attr_reader :items

  def initialize(items)
    @items = items
  end

  def all
    @items
  end

  def find_by_id(id)
    nil if !a_valid_id?(id)

    @items.find do |item|
      item.id == id
    end
  end

  def a_valid_id?(id)
    @items.any? do |item| item.id == id
    end
  end

  def find_by_name(name)
    @items.find{|item| item.name.downcase == name.downcase}
  end

  def find_all_by_name(string)
    @items.find_all do |item|
      item.name.downcase.include?(string.downcase)
    end
  end
  
  def create(attribute)
    new_id = @items.last.id + 1
    @items << Item.new({:id => new_id, :name => attribute})
  end
  
  def find_all_with_description(string)
    @items.find_all do |item|
      item.description.downcase.include?(string.downcase)
    end
  end

  def find_all_by_price(price)
    @items.find_all do |item|
      item.unit_price == price.to_f
    end
  end
  
  def find_all_by_price_in_range(low, high)
    @items.find_all do |item|
      item.unit_price >= low.to_f && item.unit_price <= high.to_f
    end
  end
  
  def find_all_by_merchant_id(id)
    @items.find_all do |item|
      item.merchant_id == id.to_i
    end
  end

  def create(attributes)
    new_id = @items.last.id + 1
    attributes[:id] = new_id
    @items << Item.new(attributes)
  end

  def update(id, attributes)
    @items.each do |item|
      if item.id == id
      item.update(attributes)
      end
    end
  end
  
  def delete(id)
    @items.delete(find_by_id(id))
  end

  ##### Generate Items
  def self.create_items(hash)
    contents = CSV.open hash, headers: true, header_converters: :symbol, quote_char: '"'
    items = []
    items << make_item_object(contents)
  end
  
  def self.make_item_object(contents)
    contents.map do |row|
      item = {
              :id => row[:id], 
              :name => row[:name],
              :description => row[:description],
              :unit_price => row[:unit_price],
              :created_at => row[:created_at],
              :updated_at => row[:updated_at],
              :merchant_id => row[:merchant_id]
            }
      Item.new(item)
    end
  end

end
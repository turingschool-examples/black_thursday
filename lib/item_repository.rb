require 'bigdecimal'

class ItemRepository
  attr_reader :items

  def initialize(items, engine)
    @items = create_items(items)
    @engine = engine
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
    @items << Item.new({:id => new_id, :name => attribute}, self)
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
  
  def find_merchant_by_id(id)
    @engine.find_by_merchant_id(id)
  end

  def find_all_by_merchant_id(id)
    @items.find_all do |item|
      item.merchant_id == id.to_i
    end
  end

  def create(attributes)
    new_id = @items.last.id + 1
    attributes[:id] = new_id
    @items << Item.new(attributes, self)
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
  def create_items(filepath)
    contents = CSV.open filepath, headers: true, header_converters: :symbol, quote_char: '"'
    make_item_object(contents)
  end
  
  def make_item_object(contents)
    contents.map do |row|
      item = {
              :id => row[:id].to_i, 
              :name => row[:name],
              :description => row[:description],
              :unit_price => row[:unit_price].to_f,
              :created_at => row[:created_at],
              :updated_at => row[:updated_at],
              :merchant_id => row[:merchant_id].to_i
            }
      Item.new(item, self)
    end
  end

end
require_relative 'item'

class ItemRepository
  attr_reader :items

  def initialize(file_path, engine)
    @engine = engine
    @items = create_repository(file_path)
  end

  def create_repository(file_path)
    file = CSV.readlines(file_path, headers: true, header_converters: :symbol)
    file.map do |row|
      Item.new(row)
    end
  end

  def inspect
    "#<#{self.class} #{@items.size} rows>"
  end

  def all
    @items
  end

  def find_by_id(id)
    @items.find do |item|
      item.id.to_i == id
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

  def find_all_by_merchant_id(merchant_id)
    @items.find_all do |item|
      item.merchant_id.to_i == merchant_id
    end
  end

  def max_item_id
    @items.max_by do |item|
      item.id
    end.id
  end

  def create(attributes)
    @items.push(Item.new({
                          id: (max_item_id + 1),
                          name: attributes[:name],
                          description: attributes[:description],
                          unit_price: attributes[:unit_price],
                          merchant_id: attributes[:merchant_id],
                          created_at: attributes[:created_at] = Time.now.to_s,
                          updated_at: attributes[:updated_at] = Time.now.to_s
                          }))
  end

  def update(id, attributes)
    return nil if find_by_id(id).nil?
    attributes.each do |key, value|
      if value == attributes[:name]
        find_by_id(id).name = attributes[key]
      elsif value == attributes[:description]
        find_by_id(id).description = attributes[key]
      elsif value == attributes[:unit_price]
        find_by_id(id).unit_price = attributes[key]
      end
    end
    find_by_id(id).updated_at = Time.now.round
  end

  def delete(id)
    @items.delete(find_by_id(id))
  end
end

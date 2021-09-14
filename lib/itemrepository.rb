require 'csv'

class ItemRepository

  def initialize(path)
    @path = path
    @rows = CSV.read(@path, headers: true, header_converters: :symbol)
    @all = all
  end

  def all
    @rows.map do |row|
      Item.new(row)
    end
  end

  def find_by_id(id)
    @all.find do |row|
      row.id == id
    end
  end

  def find_by_name(name)
    @all.find do |row|
      row.name == name
    end
  end

  def find_all_with_description(description)
    @all.find_all do |row|
      row.description == description
    end
  end

  def find_all_by_price(price)
    @all.find_all do |row|
      row.unit_price == price
    end
  end

  def find_all_by_price_in_range(num1, num2)
    @all.find_all do |row|
      row.unit_price.between?(num1, num2)
    end
  end

  def find_all_by_merchant_id(merchant_id)
    @all.find_all do |row|
      row.merchant_id == merchant_id
    end
  end

  def create(attributes)
    attributes[:id] = @all.last.id.to_i + 1
    @all << Item.new(attributes)
  end

  def update(id, attributes)
    item_to_update = find_by_id(id)

    if attributes[:name] != nil
      item_to_update.name = attributes[:name]
    end
    if attributes[:description] != nil
      item_to_update.description = attributes[:description]
    end
    if attributes[:unit_price] != nil
      item_to_update.unit_price = attributes[:unit_price]
    end
    item_to_update.updated_at = Time.now
    item_to_update
  end

  def delete(id)
    item_to_delete = find_by_id(id)
    @all.delete(item_to_delete)
  end
end

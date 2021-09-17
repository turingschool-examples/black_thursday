require 'csv'
require_relative 'item'

class ItemRepository
  attr_reader :all

  def initialize(path)
    @all  = generate(path)
  end

<<<<<<< HEAD:lib/itemrepository.rb
  def all
    @rows.map do |row|
=======
  def inspect
    "#<#{self.class} #{@items.size} rows>"
  end

  def generate(path)
    rows = CSV.read(path, headers: true, header_converters: :symbol)

    rows.map do |row|
>>>>>>> ea9ca2ca91942479de27b959c172dd9cd604de8a:lib/item_repository.rb
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
<<<<<<< HEAD:lib/itemrepository.rb
      row.description == description
=======
      row.description.downcase == description.downcase
>>>>>>> ea9ca2ca91942479de27b959c172dd9cd604de8a:lib/item_repository.rb
    end
  end

  def find_all_by_price(price)
    @all.find_all do |row|
      row.unit_price == price
    end
  end

<<<<<<< HEAD:lib/itemrepository.rb
  def find_all_by_price_in_range(num1, num2)
    @all.find_all do |row|
      row.unit_price.between?(num1, num2)
=======
  def find_all_by_price_in_range(range)
    @all.find_all do |row|
      range.cover?(row.unit_price)
>>>>>>> ea9ca2ca91942479de27b959c172dd9cd604de8a:lib/item_repository.rb
    end
  end

  def find_all_by_merchant_id(merchant_id)
    @all.find_all do |row|
      row.merchant_id == merchant_id
    end
  end

  def create(attributes)
    attributes[:id] = @all.last.id + 1
    attributes[:created_at] = Time.now.to_s
    attributes[:updated_at] = Time.now.to_s
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
    if item_to_update
      item_to_update.updated_at = Time.now
    end
    item_to_update
  end

  def delete(id)
    item_to_delete = find_by_id(id)
    @all.delete(item_to_delete)
  end
end

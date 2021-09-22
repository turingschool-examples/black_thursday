require 'csv'
require_relative 'item'
require 'bigdecimal'
require 'bigdecimal/util'
require 'time'

class ItemRepository
  attr_reader    :all

  def initialize(file_path, engine)
    @engine = engine
    @all = create_repository(file_path)
  end

  def create_repository(file_path)
    all = []

    csv = CSV.read(file_path, headers: true, header_converters: :symbol)
     csv.map do |row|
       all << Item.new(row)
    end
    all
  end

  def find_by_id(id)
    @all.find do |item|
      item.id == id
    end
  end

  def find_by_name(name)
    @all.find do |item|
      item.name == name
    end
  end

  def find_all_with_description(search_term)

    @all.find_all do |item|
      description = item.description.downcase
      description == search_term.downcase
    end
  end


  def find_all_by_price(unit_price)

    @all.find_all do |item|
      item.unit_price == unit_price
    end
  end

  def find_all_by_price_in_range(range)
    result = @all.find_all do |item|
      range.include?(item.unit_price.to_f)
    end
    result
  end

  def find_all_by_merchant_id(merchant_id)

    @all.find_all do |item|
      item.merchant_id == merchant_id
    end
  end

  def create(attributes)
    id_max = @all.max_by {|item| item.id}
    attributes[:id] = id_max.id + 1
    attributes[:created_at] = Time.now.to_s
    attributes[:updated_at] = Time.now.to_s
    new_item = Item.new(attributes)
    @all << new_item
  end

  def update(id, attributes)
    updated_item = self.find_by_id(id)
    if updated_item != nil
      updated_item.name = attributes[:name] if attributes[:name]
      updated_item.description = attributes[:description] if attributes[:description]
      updated_item.unit_price = attributes[:unit_price] if attributes[:unit_price]
      updated_item.updated_at = Time.now
    end
  end

  def delete(id)
    x = (self.all).find_index(self.find_by_id(id))
    if x != nil
      self.all.delete_at(x)
    end
    self.all
  end

  def inspect
   "#<#{self.class} #{@items.size} rows>"
  end

end

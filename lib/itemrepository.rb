require 'csv'
require_relative 'item'

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
    @all.find_all do |item|
      item.id == id
    end.pop
  end

  def find_by_name(name)
    @all.find_all do |item|
      item.name == name
    end.pop
  end

  def find_all_with_description(description)

    description1 = description.downcase!
    @all.find_all do |item|
      item.description.downcase!
      item.description == description1
    end
  end


  def find_all_by_price(unit_price)

    @all.find_all do |item|
      item.unit_price == unit_price
    end
  end

  def find_all_by_price_in_range(range)

    result = @all.find_all do |item|
      item.unit_price.between?(range)
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
    new = Item.new(attributes)
    @all.push(new)
  end

  def update(id, attributes)

      updated_item = self.find_by_id(id)
      updated_item.name = attributes[:name]
      updated_item.description = attributes[:description]
      updated_item.unit_price = attributes[:unit_price]
    updated_item

  end

  def delete(id)
    x = (self.all).find_index(self.find_by_id(id))
    self.all.delete_at(x)
    self.all
  end

  def inspect
   "#<#{self.class} #{@items.size} rows>"
  end

end

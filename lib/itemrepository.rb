class ItemRepository

  attr_reader    :all

  def initialize(all)
    @all    = all
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

    @all.find_all do |item|
      item.description == description
    end
  end
  def find_all_by_price(unit_price)

    @all.find_all do |item|
      item.unit_price == unit_price
    end
  end
  def find_all_by_price_in_range(num1, num2)

    result = @all.find_all do |item|
      item.unit_price.between?(num1, num2)
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

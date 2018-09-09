class ItemRepo < CsvAdaptor

  attr_reader :data_file,
              :items

  def initialize(data_file)
    @data_file = data_file
    @items = []
  end

  def all_item_characteristics(data_file)
    load_items(data_file)
  end

  def all
    load_items(data_file).each do |item_info|
      @items << Item.new(item_info)
    end
    @items
  end

  def find_by_id(id)
    @items.each do |item|
      if item.id == id
        return item
      end
    end
    nil
  end

  def find_by_name(name)
    @items.each do |item|
      if item.name == name
        return item
      end
    end
    nil
  end

  def find_all_with_description(description)
    @items.find_all do |item|
      item.description.downcase.include? description.downcase
    end
  end

  def find_all_by_price(price)
    @items.find_all do |item|
      item.unit_price_to_dollars == price
    end
  end

  def find_all_by_price_in_range(range)
    @items.find_all do |item|
      item.unit_price_to_dollars >= range.begin && item.unit_price_to_dollars <= range.end
    end
  end

  def find_all_by_merchant_id(merchant_id)
    @items.find_all do |item|
      item.merchant_id == merchant_id
    end
  end

  def find_highest_item_id
    @items.max_by do |item|
      item.id
    end.id
  end

  def create(attributes)
    item = Item.new(attributes)
    item.create_id(find_highest_item_id + 1)
    item
  end

  def update(id, attributes)
    item = find_by_id(id)
    new_name = attributes[:name]
    new_description = attributes[:description]
    new_unit_price = attributes[:unit_price]
    item.change_name(new_name)
    item.change_description(new_description)
    item.change_unit_price(new_unit_price)
    item.change_updated_at
    item
  end

  def delete(id)
    @items.delete_if do |item|
      item.id == id
    end
  end

end

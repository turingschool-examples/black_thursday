# frozen_string_literal: true

class ItemRepository
  attr_reader :items

  def initialize(filename)
    @items = create_items(filename)
  end

  def create_items(filename)
    FileIo.process_csv(filename, Item)
  end

  def all
    @items
  end

  def find_by_id(id)
    @items.find { |item| item.id == id }
  end

  def find_by_name(name)
    @items.find do |item|
      item.name.downcase == name.downcase
    end
  end

  def find_all_with_description(description)
    @items.find_all do |item|
      item_description = item.description.downcase
      item_description.include?(description.downcase)
    end
  end

  def find_all_by_price(price)
    @items.find_all do |item|
      item.unit_price == price
    end
  end

  def find_all_by_price_in_range(range)
    @items.find_all do |item|
      range.cover?(item.unit_price)
    end
  end

  def find_all_by_merchant_id(merchant_id)
    @items.find_all do |item|
      item.merchant_id == merchant_id
    end
  end

  def create_first_item(attributes)
    item = Item.new(attributes)
    item.update_id(1)
    @items << item
  end

  def find_max_id
    @items.max_by(&:id).id
  end

  def create(attributes)
    if @items == []
      create_first_item(attributes)
    else
      new_item = Item.new(attributes)
      new_item.update_id(find_max_id + 1)
      @items << new_item
    end
  end

  def update(id, attributes)
    item = find_by_id(id)
    item.update_name(attributes[:name])
    item.update_description(attributes[:description])
    item.update_unit_price(attributes[:unit_price])
    item.update_time
  end

  def delete(id)
    item = find_by_id(id)
    @items.delete(item)
  end
end

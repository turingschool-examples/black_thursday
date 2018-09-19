
require 'pry'

require_relative 'finderclass'

require_relative 'item'


class ItemRepository

  attr_reader :all

  def initialize(data)
    @data = data
    @items = []
    make_items
    @all = @items
  end

  def make_items(data = @data)
    data.each { |key, value|
      hash = make_hash(key, value)
      item = Item.new(hash)
      @items << item
    }
  end

  def make_hash(key, value)
    hash = {id: key.to_s.to_i}
    value.each { |col, data| hash[col] = data }
    return hash
  end


  # --- Spec Harness Requirement ---

  # TO DO - TEST ME
  def inspect
    "#<#{self.class} #{@all.size} rows>"
  end


  # --- Find By ---

  def find_by_id(id)
    FinderClass.find_by(all, :id, id)
  end

  def find_by_name(name)
    FinderClass.find_by_insensitive(all, :name, name)
  end

  def find_all_with_description(desc)
    FinderClass.find_by_fragment(all, :description, desc)
  end

  def find_all_by_price(price)
    FinderClass.find_all_by(all, :unit_price, price)
  end

  def find_all_by_price_in_range(range) # range instance like (0..200)
    FinderClass.find_by_range(all, :unit_price, range)
  end

  def find_all_by_merchant_id(id)
    FinderClass.find_all_by(all, :merchant_id, id)
  end


  # --- CRUD ---

  def create(hash)
    last = FinderClass.find_max(all, :id)
    new_id = last.id + 1
    hash[:id] = new_id
    item = Item.new(hash)
    @items << item
    return item
  end

  def update(id, attributes)
    item = find_by_id(id)
    item.make_update(attributes) if item
  end

  def delete(id)
    @items.delete_if{ |item| item.id == id }
  end














end

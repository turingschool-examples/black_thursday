# frozen_string_literal: true

require 'csv'
require_relative 'item'
require_relative 'csv_readable'

class ItemRepository
  include CSV_readable

  attr_reader :all

  def initialize(path)
    @all  = generate(path)
  end

  def inspect
    "#<#{self.class} #{@items.size} rows>"
  end

  def generate(path)
    rows = read_csv(path)

    rows.map do |row|
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
      row.description.downcase == description.downcase
    end
  end

  def find_all_by_price(price)
    @all.find_all do |row|
      row.unit_price == price
    end
  end

  def find_all_by_price_in_range(range)
    @all.find_all do |row|
      range.cover?(row.unit_price)
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
      item_to_update.update_name(attributes[:name])
    end
    if attributes[:description] != nil
      item_to_update.update_description(attributes[:description])
    end
    if attributes[:unit_price] != nil
      item_to_update.update_up(attributes[:unit_price])
    end
    if item_to_update
      item_to_update.update_updated_at
    end
    item_to_update
  end

  def delete(id)
    item_to_delete = find_by_id(id)
    @all.delete(item_to_delete)
  end
end

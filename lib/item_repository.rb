# frozen_string_literal: true
require_relative 'base_repository'
require_relative 'item'

# item repo
class ItemRepository < BaseRepository
  def items
    @models
  end

  def populate
    @models ||= csv_table_data.map { |attribute_hash| Item.new(attribute_hash, self) }
  end

  def find_all_with_description(item_description)
    items.find_all do |item|
      item.description.downcase.include?(item_description.downcase)
    end
  end

  def find_all_by_price(price)
    items.find_all do |item|
      item.unit_price_to_dollars == price
    end
  end

  def find_all_by_price_in_range(range)
    items.find_all do |item|
      range.include?(item.unit_price_to_dollars)
    end
  end

  def find_all_by_merchant_id(id)
    items.find_all { |item| item.merchant_id == id }
  end

  def find_highest_id
    items.map(&:id).max
  end

  def create_new_id
    find_highest_id + 1
  end

  def create(attributes)
    attributes[:id] = create_new_id
    attributes[:created_at] = Time.now.to_s
    attributes[:updated_at] = Time.now.to_s
    items << Item.new(attributes, 'parent')
  end

  def update(id, attributes)
    return nil if find_by_id(id).nil?
    to_update = find_by_id(id)
    to_update.change_name(attributes[:name]) if attributes[:name]
    to_update.change_description(attributes[:description])
    to_update.change_updated_at
    to_update.change_unit_price(attributes[:unit_price])
  end

  def pass_merchant_id_to_merchant_repo(merchant_id)
    @parent.pass_merchant_id_to_merchant_repo(merchant_id)
  end
end

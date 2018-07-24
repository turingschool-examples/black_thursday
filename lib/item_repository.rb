# frozen_string_literal: true
require 'pry'
require './lib/item'
require 'bigdecimal'

# Item repository class
class ItemRepository
  def initialize
    @items = {}
  end

  def create(params)
    params[:id] = @items.max[0] + 1 if params[:id].nil?

    Item.new(params).tap do |item|
      @items[params[:id].to_i] = item
    end
  end

  def all
    item_pairs = @items.to_a.flatten
    item_pairs.keep_if do |thing|
      thing.is_a?(Item)
    end
  end

  def find_by_id(id)
    @items.fetch(id)
  end

  def find_by_name(name)
    @items.find do |_, item|
      item.name.downcase == name.downcase
    end.last
  end

  def find_all_with_description(input)
    found_items = @items.find_all do |_, item|
      item.description.downcase.include?(input.downcase)
    end.flatten
    found_items.keep_if do |thing|
      thing.is_a?(Item)
    end
  end

  def find_all_by_price(price)
    found_items = @items.find_all do |_, item|
      item.unit_price == price
    end.flatten
    found_items.keep_if do |thing|
      thing.is_a?(Item)
    end
  end

  def find_all_by_price_in_range(range)
    found_items = @items.find_all do |_, item|
      range.member?(item.unit_price)
    end.flatten
    found_items.keep_if do |thing|
      thing.is_a?(Item)
    end
  end

  def find_all_by_merchant_id(id)
    found_items = @items.find_all do |_, item|
      item.merchant_id == id
    end.flatten
    found_items.keep_if do |thing|
      thing.is_a?(Item)
    end
  end

  def update(id, params)
    sig_fig = params[:unit_price].to_s.size - 1

    item = find_by_id(id)
    item.name = params[:name] unless params[:name].nil?
    item.description = params[:description] unless params[:description].nil?
    item.unit_price = BigDecimal(params[:unit_price], sig_fig) unless params[:unit_price].nil?
    item.updated_at = Time.now
  end

  def delete(id)
    @items.delete(id)
  end
end

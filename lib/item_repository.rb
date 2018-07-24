# frozen_string_literal: true
require 'pry'
require_relative './item'
require 'time'
require 'bigdecimal'

# Item repository class
class ItemRepository
  def initialize
    @items = {}
  end

  def populate_from_csv(filepath)
    CSV.foreach(filepath, headers: true, header_converters: :symbol) do |row|
      row[:unit_price] = BigDecimal(row[:unit_price].dup.insert(-3, '.'))
      row[:created_at] = Time.parse(row[:created_at])
      row[:updated_at] = Time.parse(row[:updated_at])
      create(row)
    end
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
    return nil unless @items.key?(id)
    @items.fetch(id)
  end

  def find_by_name(name)
    all.find do |item|
      item.name.downcase == name.downcase
    end
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
    float_price = price.to_f
    found_items = @items.find_all do |_, item|
      item.unit_price_to_dollars == float_price
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
    return nil unless @items.key?(id)
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

  def inspect
    "#<#{self.class} #{@items.size} rows>"
  end
end
